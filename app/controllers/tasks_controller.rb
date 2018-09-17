# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Eatech CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require 'google_drive/google_docs'
class TasksController < ApplicationController
  before_action :require_user
  before_action :set_current_tab, only: [:index, :show, :new, :edit]
  before_action :update_sidebar, only: [:index, :new, :edit ]
  skip_before_action :verify_authenticity_token
  #before_action :google_drive_login, :only => [:index, :create]
  before_action :set_paper_trail_whodunnit

  # GOOGLE_CLIENT_ID = "318261922103-6o5ui2qui55luqss9d2gpsbsukianb39.apps.googleusercontent.com"
  # GOOGLE_CLIENT_SECRET = "WlTtICFYG64yummKqFlpz5hf"
  # GOOGLE_CLIENT_REDIRECT_URI = "http://localhost:3000/oauth2callback"
  respond_to :docx
  # GET /tasks
  #----------------------------------------------------------------------------
  def index
    @view = view
    # data = UserTask.where(:user_id => current_user.id)
    # google_session = GoogleDrive.login_with_oauth(session[:google_token])
    # if current_user.is_super_admin?
    # if data.present?
    #   @tasks = Task.where(company_id: current_user.company_id).where(:id => data.map{|s|s.task_id})
    # else  
    #   @tasks = Task.where(company_id: current_user.company_id)
    # end 

    if current_user.is_super_admin?
      @tasks = Task.all.order("id DESC")
    elsif current_user.is_admin?
      @tasks = Task.where(:company_id => current_user.company_id).order("id DESC")
    elsif current_user.is_manager? 
      arr = []
      current_user.groups.each do |group|
        group.users.each do |user|
          arr << user.id
        end
      end
      @tasks = Task.where(task_created_id: arr).order("id DESC")
    else
      
      data = UserTask.where(:user_id => current_user.id)
      # @tasks = Task.where(:company_id => current_user.company_id).where(task_created_id: current_user.id)
      if data.present?
        @tasks = Task.where(company_id: current_user.company_id).where(:id => data.map{|s|s.task_id}).order("id DESC")
      else 
        @tasks = []
      end
    end

    #raise   @tasks.inspect



   # @my_tasks = Task.visible_on_dashboard(current_user).includes(:user, :asset).by_due_at
    
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

    school_form_ids = []
    AccessOnForm.where(company_id: current_user.company_id).each do |access_on_form|
      if access_on_form.users_id.present? && access_on_form.users_id.include?(current_user.id)
        school_form_ids << access_on_form.school_form_id
      end
    end
    @school_forms = SchoolForm.where(id: school_form_ids)

    if params[:related]
      model, id = params[:related].split(/_(\d+)/)
      if related = model.classify.constantize.my.find_by_id(id)
        instance_variable_set("@asset", related)
      else
        respond_to_related_not_found(model) && return
      end
    end
    
    #respond_with(@task)
  end

  # GET /tasks/1/edit                                                      AJAX
  #----------------------------------------------------------------------------
  def edit

    @view = view
    @task = Task.find(params[:id])
    #@task = Task.tracked_by(current_user).find(params[:id])
    @bucket = Setting.unroll(:task_bucket)[1..-1] << [t(:due_specific_date, default: 'On Specific Date...'), :specific_time]
    @category = Setting.unroll(:task_category)
    @asset = @task.asset if @task.asset_id?
    @user_tasks = UserTask.where(task_id: @task.id).order('position asc')
    
    if params[:previous].to_s =~ /(\d+)\z/
      @previous = Task.tracked_by(current_user).find_by_id(Regexp.last_match[1]) || Regexp.last_match[1].to_i
    end

  
  end

  # POST /tasks
  #----------------------------------------------------------------------------
  def create
    
    @view = view
    only_current_user = false
    @users_selected = params[:users].reject { |c| c.empty? } if params[:users].present?
    unless @users_selected.include?(current_user.id)
      @users_selected.unshift(current_user.id.to_s)
    end  
    if (@users_selected.count == 1) && (@users_selected.first.to_i == current_user.id)
      only_current_user = true
    end
    @task = Task.new
    @task.assigned_to = current_user.id
    @task.user_id = current_user.id
    @task.bucket = params[:task][:bucket]
    @task.name = params[:task][:name]
    @task.description = params[:task][:description]
    @task.years = params[:task][:years]
    @task.task_form_category = params[:task][:task_form_category]
    @task.school_item_no = params[:task][:school_item_no]
    @task.task_created_by = current_user.name if current_user.username.present?
    @task.task_created_id = current_user.id
    @task.company_id = current_user.company_id
    @task.task_status = "pending"
    if params["task"]["form_number"]
      @task.form_number = params["task"]["form_number"].to_i
    end
    
    if params[:task][:password_protected] == "1"
      if params[:password].present? && params[:password] && params[:password_confirmation]
        if params[:password] == params[:password_confirmation]
          @task.password = params[:password]
          @task.password_protected = true
        else
          flash[:notice] = "Password did not match."
          redirect_to new_task_path and return
        end
      end
    end

    if params[:task][:calendar]
      begin
      @task.due_at = Time.parse(params[:task][:calendar])
    rescue
      @task.due_at = Time.now
    end
    end 

      if @task.save(:validate => false)
         form_frist = FormFirst.create(:task_id => @task.id)
         form_second = FormSecond.create(:task_id => @task.id)
         form_third = ThridForm.create(:task_id => @task.id)
         @task.update_attributes({:form_first_id => form_frist.id, :form_second_id => form_second.id, :form_third_id => form_third.id, :form_number => params["task"]["form_number"].to_i})
        update_sidebar if called_from_index_page?
        pos = 0
      #  @users_selected.unshift(current_user.id.to_s) unless only_current_user
        @users_selected.uniq.each do |user_id|
          pos = pos+1
          @user_task = UserTask.new
          @user_task.user_id = user_id
          @user_task.task_id = @task.id
          @user_task.position = pos
          @user_task.save


          # Mail functionality disabled
          SchoolMailer.task_assigned(User.find(user_id), current_user, @task.name, @task.password_protected ? @task.password : '').deliver_now
        end
        
        if params[:restricted_groups].present?

           params[:restricted_groups].each do |s|

             @restricted_group = RestrictedGroup.new
             @restricted_group.group_id = s
             @restricted_group.task_id = @task.id
             @restricted_group.save

           end 
        end

        if params['option_value'].present?
          params['option_value'].each do |key, value|
            OptionValue.create(:task_form_tag_id => key, :task_form_tag_value_id => value, :task_id => @task.id)
          end  
        end

          
          if params["files"].present?
            params["files"].each do |key, value|
              task_file = TaskFile.new
              task_file.file = value
              task_file.task_id = @task.id
              task_file.save
            end 
          end 

          if params["supplementary_files"].present?
            params["supplementary_files"].each do |key, value|
              task_file = SupplementaryTaskFile.new
              task_file.file = value
              task_file.task_id = @task.id
              task_file.save
            end  
          end


        

      
        # if params[:file_upload].present?
        #   # google_session = GoogleDrive.login_with_oauth(session[:google_token])
        #   # file_uploaded_to_drive = google_session.upload_from_file(params[:file_upload].path, params[:file_upload].original_filename, convert: false)

        #  # drive = Google::Apis::DriveV3::DriveService.new
        #  # drive.authorization = Signet::OAuth2::Client.new( client_id: GOOGLE_CLIENT_ID, client_secret: GOOGLE_CLIENT_SECRET, access_token: session[:google_token], :access_type => 'offline', :scope => "https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/drive.file")
        #  # drive.authorization.expires_in = 7200
          
        #  # file_metadata = {name: params[:file_upload].original_filename, mime_type: "application/vnd.google-apps.document"}
        #  # file_uploaded_to_drive = drive.create_file(file_metadata, fields: 'id', upload_source: params[:file_upload].path)

        #   @users_selected.each do |user_id|
        #     unless UserTask.find_by_user_id(user_id).position == 1
        #       user_permission = { type: 'user', role: 'writer', with_link: true, email_address: User.find(user_id).email }
        #       drive.create_permission(file_uploaded_to_drive.id, user_permission, fields: "id")
        #     end
        #   end

        #   @file_upload = FileUpload.new
        #   @file_upload.task_id = @task.id
        #   @file_upload.file_name = params[:file_upload].original_filename
        #   @file_upload.file = "https://docs.google.com/document/d/#{file_uploaded_to_drive.id}/edit"
        #   @file_upload.save
        # end  
  
    end
    redirect_to :tasks
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
    if params[:users].present?
       @users_selected = params[:users].reject { |c| c.empty? } 
    end 

    if params[:task][:password_protected] == "1"
      if params[:password].present? && params[:password_confirmation].present?
        if params[:password] == params[:password_confirmation]
          @task.update_attributes(password: params[:password]) 
          @users_selected.each do |user_id|
            if UserTask.where(task_id: @task.id).exists?(user_id: user_id)
              # Mail functionality disabled
              SchoolMailer.task_password_changed(User.find(user_id), current_user, @task.name, @task.password).deliver_now
            end
          end
        else
          flash[:notice] = "Password did not match."
          redirect_to edit_task_path(@task) and return
        end
      end
    end
   
    if @users_selected.present?
      unless UserTask.where(task_id: @task.id).count == @users_selected.count
        UserTask.where(task_id: @task.id).each do |user_task|
          unless params[:users].include?(user_task.user_id.to_s) && @task.task_created_id == user_task.user_id
            user_task.destroy
          end
        end
      end

      @pos = @task.user_tasks.count
      @users_selected.each do |user_id|
        unless UserTask.where(task_id: @task.id).exists?(user_id: user_id)
          @pos = @pos+1
          @user_task = UserTask.new
          @user_task.user_id = user_id
          @user_task.task_id = @task.id
          @user_task.position = @pos
          @user_task.save
          # Mail functionality disabled
          SchoolMailer.task_assigned(User.find(user_id), current_user, @task.name, @task.password_protected ? @task.password : '').deliver_now
        end
      end
    end 

    if params[:restricted_groups].present?
         rs_group = RestrictedGroup.where(:task_id => @task.id)
         rs_group.delete_all
           params[:restricted_groups].each do |s|
             @restricted_group = RestrictedGroup.new
             @restricted_group.group_id = s
             @restricted_group.task_id = @task.id
             @restricted_group.save
           end     
    end

    if params[:task] && params[:task][:completed]

      if params[:task][:completed] == "1"



        @user_task = UserTask.where(task_id: @task.id).where(user_id: current_user.id).first
        pos = 1
        if @user_task.present?
           pos = @user_task.position + 1
        end   
     
        if @task.user_tasks.exists?(position: pos)
          @new_user_task = @task.user_tasks.where(position: pos).last

          @task.update_attribute("assigned_to", @new_user_task.user_id)
          @task.update_attribute("task_status", "Pending" )
          # Mail functionality disabled
          SchoolMailer.task_available(User.find(@new_user_task.user_id), current_user, @task.name).deliver_now
        else  
          @task.update_attribute("completed_at", Time.now)
          @task.update_attribute("completed_by", current_user.id )
          @task.update_attribute("task_status", "Completed")
          @task.update_attribute("assigned_to",  @task.task_created_id)
          # Mail functionality disabled
          SchoolMailer.task_completed(User.find(@task.task_created_id), current_user, @task.name).deliver_now
       end
        if @user_task
          @user_task.update_attributes(approved: true, approved_time: Time.now)
        end

      elsif params[:task][:completed] == "2"
        @user_task = UserTask.where(task_id: @task.id).where(user_id: current_user.id).last
        @first_user_in_order = @task.task_created_id
        @user_task.update_attributes(rejected: true, rejected_time: Time.now)
        @task.update_attribute("assigned_to", @task.task_created_id)
        @task.update_attribute("task_status", "Return")
        # Mail functionality disabled
        SchoolMailer.task_rejected(User.find(@task.task_created_id), current_user, @task.name).deliver_now
      elsif params[:task][:completed] == "3"
        @user_task = UserTask.where(task_id: @task.id).where(user_id: current_user.id).last
        @first_user_in_order = @task.task_created_id
        @user_task.update_attributes(rejected: true, rejected_time: Time.now)
        @task.update_attribute("assigned_to", @task.task_created_id)
        @task.update_attribute("is_cancelled", true)
        @task.update_attribute("task_status", "cancelled")
      end  
    end 
    

      if @task.update_attributes(task_params)
        @task.bucket = @task.computed_bucket
        if called_from_index_page?
          if Task.bucket_empty?(@task_before_update.bucket, current_user, @view)
            @empty_bucket = @task_before_update.bucket
          end
          update_sidebar
        end

        if params['option_value']
          @task.option_values.delete_all
            params['option_value'].each do |key,value|
              OptionValue.create(:task_form_tag_id => key, :task_form_tag_value_id => value, :task_id => @task.id)
            end  
        end

     end

     if params["files"].present?
            params["files"].each do |key, value|
              @file_name = TaskFile.where(task_id: params[:id]).where( :file_file_name => value.original_filename)
              if @file_name.count > 0
                @file_name.first.destroy
              end
              task_file = TaskFile.new
              task_file.file = value
              task_file.task_id = @task.id
              task_file.save
            end 
          end 

          if params["supplementary_files"].present?
            params["supplementary_files"].each do |key, value|
              task_file = SupplementaryTaskFile.new
              task_file.file = value
              task_file.task_id = @task.id
              task_file.save
            end  
          end

       redirect_to :tasks

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
      @first_user_in_order = @task.task_created_id
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
    complete = "complete_task_" + params[:id]
    # reject =  "reject_task_" + params[:id]
    # @task_completed = params[complete] if params[complete].present?
    # @task_rejected = params[reject] if params[reject].present?
    # Make sure bucket's div gets hidden if it's the last completed task in the bucket.
    if @task
      @user_task = UserTask.find_by_user_id_and_task_id(current_user.id, @task.id)
      @user_task.update(comments: params[:taskComment])
      if params[:taskComment]
        @task_comment = TaskComment.new
        @task_comment.task_id = @task.id
        @task_comment.user_id = current_user.id
        @task_comment.user_name = [current_user.first_name, current_user.last_name].join(" ")
        @task_comment.comments = params[:taskComment]
        @task_comment.save
      end
      if params["complete"] == "1"
        pos = @user_task.position + 1
        if @task.user_tasks.exists?(position: pos)
          @new_user_task = @task.user_tasks.where(position: pos).first
          @task.update_attributes(assigned_to: @new_user_task.user_id )
        else  
          @task.update_attributes(completed_at: Time.now, completed_by: current_user.id, assigned_to: @task.task_created_id)
        end
        @user_task.update_attributes(approved: true, approved_time: Time.now)
      elsif params[complete] == "0"
        # @first_user_in_order = @task.user_tasks.where(position: 1).first
        @user_task.update_attributes(rejected: true, rejected_time: Time.now)
        @task.update_attributes(assigned_to: @task.task_created_id)
      end
    end

    if Task.bucket_empty?(params[:bucket], current_user)
      @empty_bucket = params[:bucket]
    end

    update_sidebar unless params[:bucket].blank?
    respond_with(@task)
  end

  def task_reject
    @task = Task.tracked_by(current_user).find(params[:id])
    if @task
      @user_task = UserTask.find_by_user_id_and_task_id(current_user.id, @task.id)
      if params[:taskReject]
        @task_comment = TaskComment.new
        @task_comment.task_id = @task.id 
        @task_comment.user_id = current_user.id
        @task_comment.user_name = [current_user.first_name, current_user.last_name].join(" ")
        @task_comment.comments = params[:taskReject]
        @task_comment.save
      end

      @task.update_attributes(completed_at: nil, completed_by: nil, assigned_to: @task.user_tasks.where(position: 2).first.user_id)
    end

    if Task.bucket_empty?(params[:bucket], current_user)
      @empty_bucket = params[:bucket]
    end

    update_sidebar unless params[:bucket].blank?
    respond_with(@task)
  end

  def show_files
    # @document = FileUpload.find(params[:id])
    # send_data(@document.file_contents, type: @document.content_type, filename: @document.file)
    @url = params[:url]
  end

  def set_google_drive_token
    google_doc = GoogleDrive::GoogleDocs.new(GOOGLE_CLIENT_ID,GOOGLE_CLIENT_SECRET,
                GOOGLE_CLIENT_REDIRECT_URI)
    oauth_client = google_doc.create_google_client
    auth_token = oauth_client.auth_code.get_token(params[:code], 
                 :redirect_uri => GOOGLE_CLIENT_REDIRECT_URI)
    session[:google_token] = auth_token.token if auth_token
    session[:google_token_expiry_time] = Time.now + 3600 if auth_token
    redirect_to tasks_path
  end

  def google_drive_login
    unless session[:google_token].present? && session[:google_token_expiry_time] && session[:google_token_expiry_time] > Time.now
      google_drive = GoogleDrive::GoogleDocs.new(GOOGLE_CLIENT_ID,GOOGLE_CLIENT_SECRET,
                     GOOGLE_CLIENT_REDIRECT_URI)
      auth_url = google_drive.set_google_authorize_url
      redirect_to auth_url
    end
  end

  def task_protected
    if params[:task_password].present?
      @task = Task.find(params[:task_id])
      respond_to do |format|
        if params[:task_password] == @task.password
          @authenticated = true
        else
          @authenticated = false
        end
        format.html 
        format.js { }
      end
    end
  end

  def forgot_password 
    if (params[:id])
      SchoolMailer.forgot_task_password(params[:id]).deliver_now
    end
  end

  def edit_task_password
    if (params[:id])
      @task = Task.find(params[:id])
    end
  end

  def change_task_password
    if params[:task][:password].blank?
      flash[:notice] = t(:msg_password_not_changed)
    else
      if params[:task][:password] == params[:task][:password_confirmation]
        @task = Task.find(params[:id])
        @task.password = params[:task][:password]
        @task.save

        UserTask.where(task_id: @task.id).each do |user_task|
          if User.where(id: user_task.user_id).present?
            # Mail functionality disabled
            SchoolMailer.task_password_changed(User.find(user_task.user_id), current_user, @task.name, @task.password).deliver_now
          end
        end
        flash[:notice] = "Your task password has been changed."
        redirect_to :tasks
      else
        flash[:notice] = "Password did not match."
      end
    end
  end

  def download_docx
    @view = view
    @task = Task.tracked_by(current_user).find(params[:id])
    @bucket = Setting.unroll(:task_bucket)[1..-1] << [t(:due_specific_date, default: 'On Specific Date...'), :specific_time]
    @category = Setting.unroll(:task_category)
    @asset = @task.asset if @task.asset_id?
    @user_tasks = UserTask.where(task_id: @task.id).order('position asc')

    if params[:previous].to_s =~ /(\d+)\z/
      @previous = Task.tracked_by(current_user).find_by_id(Regexp.last_match[1]) || Regexp.last_match[1].to_i
    end

    respond_to do |format|
      # format.docx do
      #   render docx: 'download_docx', filename: 'form1.docx'
      # end
      if @task.form_number == 1
        format.docx { headers["Content-Disposition"] = "attachment; filename=\"Staff Interview and Recruitment.docx\"" }
      elsif @task.form_number == 2
        format.docx { headers["Content-Disposition"] = "attachment; filename=\"Monitoring Module Delivery.docx\"" }
      elsif @task.form_number == 3
        format.docx { headers["Content-Disposition"] = "attachment; filename=\"Form.docx\"" }
      end
    end
  end

  # POST /tasks/auto_complete/query                                        AJAX
  #----------------------------------------------------------------------------
  # Handled by ApplicationController :auto_complete

  # Ajax request to filter out a list of tasks.                            AJAX
  #----------------------------------------------------------------------------
  def find_user_task
    @task = Task.find(params[:task_id])
    @user_id = params[:user_id]
    if params[:type] === "select"
      if @task.user_tasks.where(user_id: @user_id).present?
        @user_task = @task.user_tasks.where(user_id: @user_id).first
      else
        @user_task = UserTask.new
        @user_task.user_id = @user_id
        @user_task.task_id = @task.id
        @user_task.position = @task.user_tasks.last.position+1
        @user_task.save
      end
      respond_to do |format|
        format.json { render json: @user_task.id }
      end
    else 
      if @task.user_tasks.where(user_id: @user_id).present?
        @user_task = @task.user_tasks.where(user_id: @user_id)
        UserTask.destroy(@user_task.first.id)
        respond_to do |format|
          format.json { render json: false }
        end
      end
    end
  end

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



  #----------------------------------------------------------------------------
  def get_activities(options = {})
    user = activity_user
    if current_user.super_admin != true
      user = current_user
    end  
    options[:asset]    ||= activity_asset
    options[:event]    ||= activity_event
    options[:user]     ||= user
    options[:duration] ||= activity_duration
    options[:max]      ||= 500
    Version.includes(user: [:avatar]).latest(options).visible_to(current_user)
  end

  #----------------------------------------------------------------------------
  def activity_asset
    asset = current_user.pref[:activity_asset]
    if asset.nil? || asset == "all"
      nil
    else
      asset.singularize.capitalize
    end
  end

  #----------------------------------------------------------------------------
  def activity_event
    event = current_user.pref[:activity_event]
    if event == "all_events"
      %w(create update destroy)
    else
      event
    end
  end

  #----------------------------------------------------------------------------
  # TODO: this is ugly, ugly code. It's being security patched now but urgently
  # needs refactoring to use user id instead. Permuations based on name or email
  # yield incorrect results.
  def activity_user
    return nil if current_user.pref[:activity_user] == "all_users"
    return nil unless current_user.pref[:activity_user]

    is_email = current_user.pref[:activity_user].include?("@")

    user = if is_email
             User.where(email: current_user.pref[:activity_user]).first
           else # first_name middle_name last_name any_name
             name_query(current_user.pref[:activity_user])
           end

    user.is_a?(User) ? user.id : nil
  end

  def name_query(user)
    if user.include?(" ")
      user.name_permutations.map do |first, last|
        User.where(first_name: first, last_name: last)
      end.map(&:to_a).flatten.first
    else
      [User.where(first_name: user), User.where(last_name: user)].map(&:to_a).flatten.first
    end
  end

  #----------------------------------------------------------------------------
  def activity_duration
    duration = current_user.pref[:activity_duration]
    if duration
      words = duration.split("_") # "two_weeks" => 2.weeks
      if %w(one two).include?(words.first) && %w(hour day days week weeks month).include?(words.last)
        %w(zero one two).index(words.first).send(words.last)
      end
    end
  end

  def show_trails
    @activities = get_activities
    @tasks = Task.find(params[:task_id]) 
    @activities =  @tasks.versions
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
    task = nil
    if current_user.is_super_admin?
      tasks = Task.all
    elsif current_user.is_admin?
      tasks = Task.where(:company_id => current_user.company_id)
    elsif current_user.is_manager? 
      arr = []
      current_user.groups.each do |group|
        group.users.each do |user|
          arr << user.id
        end
      end
      tasks = Task.where(task_created_id: arr)
    else
      data = UserTask.where(:user_id => current_user.id)
      if data.present?
        tasks = Task.where(company_id: current_user.company_id).where(:id => data.map{|s|s.task_id})
      else 
        tasks = []
      end
    end

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
