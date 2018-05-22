class SurperTaskReportController < ApplicationController
  def task_super
  	@tasks = Task.all
    @bucket = Setting.unroll(:task_bucket)[1..-1] << [t(:due_specific_date, default: 'On Specific Date...'), :specific_time]

  end

  def report_super

  	@tasks = Task.all.order("id DESC")
   
  end
end
