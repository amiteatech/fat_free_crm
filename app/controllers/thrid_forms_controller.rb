class ThridFormsController < ApplicationController
  before_action :set_thrid_form, only: [:show, :edit, :update, :destroy]

  # GET /thrid_forms
  def index
    @thrid_forms = ThridForm.all
  end

  # GET /thrid_forms/1
  def show
  end

  # GET /thrid_forms/new
  def new
    @thrid_form = ThridForm.new
  end

  # GET /thrid_forms/1/edit
  def edit
  end

  # POST /thrid_forms
  def create
    @thrid_form = ThridForm.new(thrid_form_params)

    if @thrid_form.save
      redirect_to @thrid_form, notice: 'Thrid form was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /thrid_forms/1
  def update
    if @thrid_form.update(thrid_form_params)
      redirect_to @thrid_form, notice: 'Thrid form was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /thrid_forms/1
  def destroy
    @thrid_form.destroy
    redirect_to thrid_forms_url, notice: 'Thrid form was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thrid_form
      @thrid_form = ThridForm.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def thrid_form_params
      params.require(:thrid_form).permit(:module_title, :module_syllabus_no, :course, :module_toucht_by, :relevent_information, :student_performance, :evaluation, :module_development, :module_development_submitted_by, :module_development_submitted_date, :comments, :comments_name, :comments_signature, :comments_designation, :comments_date, :task_id)
    end
end
