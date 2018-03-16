class ReportController < ApplicationController
  def index
  	@search = Task.where(:company_id => current_user.company_id).ransack(view_context.empty_blank_params params[:q])
    @tasks = @search.result(distinct: true).includes(:user_tasks).order("id DESC")
    
    @task_form_tag_values = TaskFormTagValue.where(:company_id => current_user.company_id)
  	# @tasks = Task.where(:company_id => current_user.company_id).order("id desc")
  end
end
