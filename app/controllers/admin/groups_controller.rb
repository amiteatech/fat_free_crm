# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Eatech CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class Admin::GroupsController < Admin::ApplicationController
  before_action :setup_current_tab, only: [:index, :show]

  load_resource

  # GET /groups
  #----------------------------------------------------------------------------
  def index
    # @groups = @groups.unscoped.paginate(page: params[:page])
    @groups = @groups.unscoped.where(company_id: current_user.company_id).paginate(page: params[:page])
  end

  # GET /groups/1
  #----------------------------------------------------------------------------
  def show
    respond_with(@group)
  end

  # GET /groups/new
  #----------------------------------------------------------------------------
  def new
    respond_with(@group)
  end

  # GET /groups/1/edit
  #----------------------------------------------------------------------------
  def edit
    respond_with(@group)
  end

  # POST /groups
  #----------------------------------------------------------------------------
  def create
    @group = Group.new
    @group.name = params[:group][:name]
    @group.company_id = current_user.company_id

    if params[:group][:user_ids].count > 1
      if @group.save
        @users_selected = params[:group][:user_ids].reject { |c| c.empty? } if params[:group][:user_ids].present?
        @users_selected.uniq.each do |user_id|
          @group.user_groups.create(user: User.where(id: user_id).first)
        end
        respond_with(@group)
      end
    else
      respond_with(@group)
    end
  end

  # PUT /groups/1
  #----------------------------------------------------------------------------
  def update
    if params[:group][:user_ids].count > 1
      if @group.update_attributes(name: params[:group][:name])
        @users_selected = params[:group][:user_ids].reject { |c| c.empty? } if params[:group][:user_ids].present?
        @group.user_groups.each do |user_group|
          unless @users_selected.include?(user_group.user_id.to_s)
            user_group.destroy
          end
        end
        @users_selected.uniq.each do |user_id|
          unless @group.user_groups.exists?(user_id: user_id)
            @group.user_groups.create(user: User.where(id: user_id).first)
          end
        end
        respond_with(@group)
      end
    else
      respond_with(@group)
    end
  end

  # DELETE /groups/1
  #----------------------------------------------------------------------------
  def destroy
    @group.destroy

    respond_with(@group)
  end

  protected

  def group_params
    params[:group].permit!
  end

  def setup_current_tab
    set_current_tab('admin/groups')
  end
end
