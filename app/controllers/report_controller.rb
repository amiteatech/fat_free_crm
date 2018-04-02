class ReportController < ApplicationController
  def index
    if current_user.is_admin?
  	  @search = Task.where(:company_id => current_user.company_id).ransack(view_context.empty_blank_params params[:q])
    elsif current_user.is_manager? 
      arr = []
      current_user.groups.each do |group|
        group.users.each do |user|
          arr << user.id
        end
      end
      @tasks = Task.where(task_created_id: arr)
      @search = @tasks.ransack(view_context.empty_blank_params params[:q])
    else
      @search = Task.where(:company_id => current_user.company_id).where(task_created_id: current_user.id).ransack(view_context.empty_blank_params params[:q])
    end

    @tasks = @search.result(distinct: true).includes(:user_tasks).order("id DESC")
    
    @task_form_tag_values = TaskFormTagValue.where(:company_id => current_user.company_id)
  	# @tasks = Task.where(:company_id => current_user.company_id).order("id desc")
  	respond_to do |format|
		  format.html
		  # format.csv { send_data @tasks.to_csv }
		  format.xls 
		end
  end
end
