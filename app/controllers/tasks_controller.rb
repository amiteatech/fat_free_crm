# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Eatech CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class TasksController < ApplicationController
  before_action :require_user
  before_action :set_current_tab, only: [:index, :show]
  before_action :update_sidebar, only: :index
  skip_before_action :verify_authenticity_token

  # GET /tasks
  #----------------------------------------------------------------------------
  def index
    @view = view
    @tasks = Task.find_all_grouped(current_user, @view)

    respond_with @tasks do |format|
      format.xls { render layout: 'header' }
      format.csv { render csv: @tasks.map(&:second).flatten }
      format.xml { render xml: @tasks, except: [:subscribed_users] }
    end
  end

  # GET /tasks/1
  #----------------------------------------------------------------------------
  def show
    @task = Task.tracked_by(current_user).find(params[:id])
    respond_with(@task)
  end

  # GET /tasks/new
  #----------------------------------------------------------------------------
  def new
    @view = view
    @task = Task.new
    @bucket = Setting.unroll(:task_bucket)[1..-1] << [t(:due_specific_date, default: 'On Specific Date...'), :specific_time]
    @category = Setting.unroll(:task_category)

    if params[:related]
      model, id = params[:related].split(/_(\d+)/)
      if related = model.classify.constantize.my.find_by_id(id)
        instance_variable_set("@asset", related)
      else
        respond_to_related_not_found(model) && return
      end
    end

    respond_with(@task)
  end

  # GET /tasks/1/edit                                                      AJAX
  #----------------------------------------------------------------------------
  def edit
    @view = view
    @task = Task.tracked_by(current_user).find(params[:id])
    @bucket = Setting.unroll(:task_bucket)[1..-1] << [t(:due_specific_date, default: 'On Specific Date...'), :specific_time]
    @category = Setting.unroll(:task_category)
    @asset = @task.asset if @task.asset_id?
    @user_tasks = UserTask.where(task_id: @task.id).order('position asc')

    if params[:previous].to_s =~ /(\d+)\z/
      @previous = Task.tracked_by(current_user).find_by_id(Regexp.last_match[1]) || Regexp.last_match[1].to_i
    end

    respond_with(@task)
  end

  # POST /tasks
  #----------------------------------------------------------------------------
  def create
    @view = view
    @users_selected = params[:users].reject { |c| c.empty? } if params[:users].present?
    # @task = Task.new(task_params) # NOTE: we don't display validation messages for tasks.
    @task = Task.new
    if @users_selected.present?
      @task.assigned_to = @users_selected.first
      @task.user_id = @users_selected.first
      @task.bucket = params[:task][:bucket]
      @task.name = params[:task][:name]
      @task.description = params[:task][:description]
    end

    respond_with(@task) do |_format|
      if @task.save
        update_sidebar if called_from_index_page?
        pos = 0
        @users_selected.each do |user_id|
          pos = pos+1
          @user_task = UserTask.new
          @user_task.user_id = user_id
          @user_task.task_id = @task.id
          @user_task.position = pos
          @user_task.save
        end
        if params[:file_upload].present?
          @file_upload = FileUpload.new
          @file_upload.task_id = @task.id
          @file_upload.file = params[:file_upload].original_filename
          @file_upload.save
        end
      end
    end
  end

  # PUT /tasks/1
  #----------------------------------------------------------------------------
  def update
    @view = view
    @task = Task.tracked_by(current_user).find(params[:id])
    @task_before_update = @task.dup

    if @task.due_at && (@task.due_at < Date.today.to_time)
      @task_before_update.bucket = "overdue"
    else
      @task_before_update.bucket = @task.computed_bucket
    end
    @users_selected = params[:users].reject { |c| c.empty? } if params[:users].present?
    if @users_selected.present?
      @pos = UserTask.where(task_id: @task.id).count
      @users_selected.each do |user_id|
        unless UserTask.where(task_id: @task.id).exists?(user_id: user_id)
          @pos = @pos+1
          @user_task = UserTask.new
          @user_task.user_id = user_id
          @user_task.task_id = @task.id
          @user_task.position = @pos
          @user_task.save
        end
      end
    end

    respond_with(@task) do |_format|
      if params[:file_upload].present?
        @file_upload = FileUpload.new
        @file_upload.task_id = @task.id
        @file_upload.file = params[:file_upload].original_filename
        @file_upload.save
      end
      if @task.update_attributes(task_params)
        @task.bucket = @task.computed_bucket
        if called_from_index_page?
          if Task.bucket_empty?(@task_before_update.bucket, current_user, @view)
            @empty_bucket = @task_before_update.bucket
          end
          update_sidebar
        end
      end
    end
  end

  # DELETE /tasks/1
  #----------------------------------------------------------------------------
  def destroy
    @view = view
    @task = Task.tracked_by(current_user).find(params[:id])
    @task.destroy

    # Make sure bucket's div gets hidden if we're deleting last task in the bucket.
    if Task.bucket_empty?(params[:bucket], current_user, @view)
      @empty_bucket = params[:bucket]
    end

    update_sidebar if called_from_index_page?
    respond_with(@task)
  end

  # PUT /tasks/1/complete
  #----------------------------------------------------------------------------
  def complete
    @task = Task.tracked_by(current_user).find(params[:id])
    # Make sure bucket's div gets hidden if it's the last completed task in the bucket.
    if @task
      @user_task = UserTask.where(task_id: @task.id).where(user_id: current_user.id).first
      pos = @user_task.position + 1
      if @task.user_tasks.exists?(position: pos)
        @new_user_task = @task.user_tasks.where(position: pos).first
        @task.update_attributes(assigned_to: @new_user_task.user_id )
      else  
        @task.update_attributes(completed_at: Time.now, completed_by: current_user.id)
      end
      @user_task.update_attributes(approved: true, approved_time: Time.now)
    end
    if Task.bucket_empty?(params[:bucket], current_user)
      @empty_bucket = params[:bucket]
    end

    update_sidebar unless params[:bucket].blank?
    respond_with(@task)
  end

  # PUT /tasks/1/uncomplete
  #----------------------------------------------------------------------------
  def uncomplete
    @task = Task.tracked_by(current_user).find(params[:id])
    @task.update_attributes(completed_at: nil, completed_by: nil) if @task

    # Make sure bucket's div gets hidden if we're deleting last task in the bucket.
    if Task.bucket_empty?(params[:bucket], current_user, @view)
      @empty_bucket = params[:bucket]
    end

    update_sidebar
    respond_with(@task)
  end 

  # PUT /tasks/1/reject
  #----------------------------------------------------------------------------
  def reject
    @task = Task.tracked_by(current_user).find(params[:id])
    if @task
      @user_task = UserTask.where(task_id: @task.id).where(user_id: current_user.id).first
      @first_user_in_order = @task.user_tasks.where(position: 1).first
      @user_task.update_attributes(rejected: true, rejected_time: Time.now)
      @task.update_attributes(assigned_to: @first_user_in_order.user_id)
    end
    # Make sure bucket's div gets hidden if it's the last completed task in the bucket.
    if Task.bucket_empty?(params[:bucket], current_user)
      @empty_bucket = params[:bucket]
    end

    update_sidebar unless params[:bucket].blank?
    respond_with(@task)
  end 

  def task_comment
    @task = Task.tracked_by(current_user).find(params[:id])
    @user_task =  UserTask.find_by_user_id_and_task_id(current_user.id, @task.id)
    @user_task.update(comments: params[:taskComment])

    if Task.bucket_empty?(params[:bucket], current_user)
      @empty_bucket = params[:bucket]
    end

    update_sidebar unless params[:bucket].blank?
    respond_with(@task)
  end

  # POST /tasks/auto_complete/query                                        AJAX
  #----------------------------------------------------------------------------
  # Handled by ApplicationController :auto_complete

  # Ajax request to filter out a list of tasks.                            AJAX
  #----------------------------------------------------------------------------
  def filter
    @view = view

    update_session do |filters|
      if params[:checked].true?
        filters << params[:filter]
      else
        filters.delete(params[:filter])
      end
    end
  end

  protected

  def task_params
    return {} unless params[:task]
    params[:task].permit!
  end

  private

  # Yields array of current filters and updates the session using new values.
  #----------------------------------------------------------------------------
  def update_session
    name = "filter_by_task_#{@view}"
    filters = (session[name].nil? ? [] : session[name].split(","))
    yield filters
    session[name] = filters.uniq.join(",")
  end

  # Collect data necessary to render filters sidebar.
  #----------------------------------------------------------------------------
  def update_sidebar
    @view = view
    @task_total = Task.totals(current_user, @view)

    # Update filters session if we added, deleted, or completed a task.
    if @task
      update_session do |filters|
        if @empty_bucket  # deleted, completed, rescheduled, or reassigned and need to hide a bucket
          filters.delete(@empty_bucket)
        elsif !@task.deleted_at && !@task.completed_at # created new task
          filters << @task.computed_bucket
        end
      end
    end

    # Create default filters if filters session is empty.
    name = "filter_by_task_#{@view}"
    unless session[name]
      filters = @task_total.keys.select { |key| key != :all && @task_total[key] != 0 }.join(",")
      session[name] = filters unless filters.blank?
    end
  end

  # Ensure view is allowed
  #----------------------------------------------------------------------------
  def view
    view = params[:view]
    views = Task::ALLOWED_VIEWS
    views.include?(view) ? view : views.first
  end
end
