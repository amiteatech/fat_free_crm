class TaskFormTagValuesController < ApplicationController
  before_action :set_task_form_tag_value, only: [:show, :edit, :update, :destroy]

  # GET /task_form_tag_values
  def index
    @task_form_tag_values = TaskFormTagValue.all
    @task_form_tags = TaskFormTag.where(:status => true)
    @task_form_tag_value = TaskFormTagValue.new
  end

  # GET /task_form_tag_values/1
  def show
  end

  # GET /task_form_tag_values/new
  def new
    @task_form_tag_value = TaskFormTagValue.new
  end

  # GET /task_form_tag_values/1/edit
  def edit
  end

  # POST /task_form_tag_values
  def create
    @task_form_tag_value = TaskFormTagValue.new(task_form_tag_value_params)

    if @task_form_tag_value.save
      redirect_to task_form_tag_values_url, notice: 'Task form tag value was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /task_form_tag_values/1
  def update
    if @task_form_tag_value.update(task_form_tag_value_params)
      redirect_to task_form_tag_values_url, notice: 'Task form tag value was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /task_form_tag_values/1
  def destroy
    @task_form_tag_value.destroy
    redirect_to task_form_tag_values_url, notice: 'Task form tag value was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_form_tag_value
       @task_form_tags = TaskFormTag.where(:status => true)
      @task_form_tag_value = TaskFormTagValue.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_form_tag_value_params
      params.require(:task_form_tag_value).permit(:name, :task_form_tag_id, :company_id)
    end
end
