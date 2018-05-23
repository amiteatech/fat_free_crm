class SurperTaskReportController < ApplicationController
  def task_super
  	@tasks = Task.all.order("id DESC")
  end

  def report_super
  	@tasks = Task.all.order("id DESC")
  end
end
