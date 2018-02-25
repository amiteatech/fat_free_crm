class TaskYearsController < ApplicationController
  before_action :set_task_year, only: [:show, :edit, :update, :destroy]

  # GET /task_years
  def index
    @task_years = TaskYear.where(:company_id => current_user.company_id)
  end

  # GET /task_years/1
  def show
  end

  # GET /task_years/new
  def new
    @task_year = TaskYear.new
  end

  # GET /task_years/1/edit
  def edit
  end

  # POST /task_years
  def create
    @task_year = TaskYear.new(task_year_params)
    @task_year.company_id = current_user.company_id
    @task_year.status = true
    if @task_year.save
      redirect_to task_years_url, notice: 'Task year was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /task_years/1
  def update
    if @task_year.update(task_year_params)
      redirect_to task_years_url, notice: 'Task year was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /task_years/1
  def destroy
    @task_year.update_attribute("status", false)
    redirect_to task_years_url, notice: 'Task year was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_year
      @task_year = TaskYear.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_year_params
      params.require(:task_year).permit(:name, :status, :company_id)
    end
end
