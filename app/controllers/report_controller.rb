class ReportController < ApplicationController
  def index
  	@tasks = Task.where("id > 0")
  end
end
