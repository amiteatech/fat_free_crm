class TaskFilesController < ApplicationController
  before_action :set_task_file, only: [:show, :edit, :update, :destroy]

  # GET /task_files
  def index
    @task_files = TaskFile.all
  end

  # GET /task_files/1
  def show
  end

  # GET /task_files/new
  def new
    @task_file = TaskFile.new
  end

  # GET /task_files/1/edit
  def edit
  end

  # POST /task_files
  def create
    @task_file = TaskFile.new(task_file_params)

    if @task_file.save
      redirect_to @task_file, notice: 'Task file was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /task_files/1
  def update
    if @task_file.update(task_file_params)
      redirect_to @task_file, notice: 'Task file was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /task_files/1
  def destroy
    @task_file.destroy
    redirect_to task_files_url, notice: 'Task file was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_file
      @task_file = TaskFile.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_file_params
      params.require(:task_file).permit(:name, :task_id)
    end
end
