class ReportController < ApplicationController
  def index
  	@tasks = Task.where(:company_id => current_user.company_id).order("id desc")
  end
end
