class FormFirstsController < ApplicationController
  before_action :set_form_first, only: [:show, :edit, :update, :destroy]

  # GET /form_firsts
  def index
    @form_firsts = FormFirst.all
  end

  # GET /form_firsts/1
  def show
  end

  # GET /form_firsts/new
  def new
    @form_first = FormFirst.new
  end

  # GET /form_firsts/1/edit
  def edit
  end

  # POST /form_firsts
  def create
    @form_first = FormFirst.new(form_first_params)

    if @form_first.save
      redirect_to @form_first, notice: 'Form first was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /form_firsts/1
  def update
    if @form_first.update(form_first_params)
      redirect_to @form_first, notice: 'Form first was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /form_firsts/1
  def destroy
    @form_first.destroy
    redirect_to form_firsts_url, notice: 'Form first was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_first
      @form_first = FormFirst.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def form_first_params
      params.require(:form_first).permit(:name, :name_of_applicant, :position_applied_for, :part_a_first_interview_date, :interviewer_comment_first, :interviewer_comment_second, :interviewer_comment_others, :part_b_first_interview_date, :interviewer_comments, :part_c_name, :part_c_signature, :part_c_date, :company_id, :user_id)
    end
end
