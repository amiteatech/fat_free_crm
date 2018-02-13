class FormSecondsController < ApplicationController
  before_action :set_form_second, only: [:show, :edit, :update, :destroy]

  # GET /form_seconds
  def index
    @form_seconds = FormSecond.all
  end

  # GET /form_seconds/1
  def show
  end

  # GET /form_seconds/new
  def new
    @form_second = FormSecond.new
  end

  # GET /form_seconds/1/edit
  def edit
  end

  # POST /form_seconds
  def create
    @form_second = FormSecond.new(form_second_params)

    if @form_second.save
      redirect_to @form_second, notice: 'Form second was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /form_seconds/1
  def update
    if @form_second.update(form_second_params)
      redirect_to @form_second, notice: 'Form second was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /form_seconds/1
  def destroy
    @form_second.destroy
    redirect_to form_seconds_url, notice: 'Form second was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_second
      @form_second = FormSecond.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def form_second_params
      params.require(:form_second).permit(:name, :module_title, :course, :course_date, :module_toucht_by_id, :company_id, :user_id, :task_id)
    end
end
