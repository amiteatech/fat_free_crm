class UserTasksController < ApplicationController
  before_action :set_user_task, only: [:show, :edit, :update, :destroy]

  # GET /user_tasks
  def index
    @user_tasks = UserTask.all
  end

  # GET /user_tasks/1
  def show
  end

  # GET /user_tasks/new
  def new
    @user_task = UserTask.new
  end

  # GET /user_tasks/1/edit
  def edit
  end

  # POST /user_tasks
  def create
    @user_task = UserTask.new(user_task_params)

    if @user_task.save
      redirect_to @user_task, notice: 'User task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /user_tasks/1
  def update
    if @user_task.update(user_task_params)
      redirect_to @user_task, notice: 'User task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /user_tasks/1
  def destroy
    @user_task.destroy
    redirect_to user_tasks_url, notice: 'User task was successfully destroyed.'
  end

  def set_position
    @user_task_id = params[:user_task_id]
    @pos = params[:position]
    @user_task = UserTask.find(@user_task_id)
    @user_task.position = @pos
    @user_task.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_task
      @user_task = UserTask.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_task_params
      params.require(:user_task).permit(:task_id, :user_id, :comments, :files, :position, :task_status, :approved_time, :rejected_time, :approved, :rejected)
    end
end
