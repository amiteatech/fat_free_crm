class TaskFormTagsController < ApplicationController
  before_action :set_task_form_tag, only: [:show, :edit, :update, :destroy]
  layout "super"
  # GET /task_form_tags
  def index
    @task_form_tags = TaskFormTag.all
    @task_form_tag = TaskFormTag.new
  end

  # GET /task_form_tags/1
  def show
  end

  # GET /task_form_tags/new
  def new
    @task_form_tag = TaskFormTag.new
  end

  # GET /task_form_tags/1/edit
  def edit
  end

  # POST /task_form_tags
  def create
    @task_form_tag = TaskFormTag.new(task_form_tag_params)

    if @task_form_tag.save
      redirect_to task_form_tags_url, notice: 'Tag was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /task_form_tags/1
  def update
    if @task_form_tag.update(task_form_tag_params)
      redirect_to task_form_tags_url, notice: 'Tag was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /task_form_tags/1
  def destroy
    @task_form_tag.destroy
    redirect_to task_form_tags_url, notice: 'Tag was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_form_tag
      @task_form_tag = TaskFormTag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_form_tag_params
      params.require(:task_form_tag).permit(:name, :status, :company_id)
    end
end
