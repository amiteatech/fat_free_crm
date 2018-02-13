class FormSecondDetailsController < ApplicationController
  before_action :set_form_second_detail, only: [:show, :edit, :update, :destroy]

  # GET /form_second_details
  def index
    @form_second_details = FormSecondDetail.all
  end

  # GET /form_second_details/1
  def show
  end

  # GET /form_second_details/new
  def new
    @form_second_detail = FormSecondDetail.new
  end

  # GET /form_second_details/1/edit
  def edit
  end

  # POST /form_second_details
  def create
    @form_second_detail = FormSecondDetail.new(form_second_detail_params)

    if @form_second_detail.save
      redirect_to @form_second_detail, notice: 'Form second detail was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /form_second_details/1
  def update
    if @form_second_detail.update(form_second_detail_params)
      redirect_to @form_second_detail, notice: 'Form second detail was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /form_second_details/1
  def destroy
    @form_second_detail.destroy
    redirect_to form_second_details_url, notice: 'Form second detail was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_second_detail
      @form_second_detail = FormSecondDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def form_second_detail_params
      params.require(:form_second_detail).permit(:week, :topic, :textbook, :teaching_activity, :teacher_remark, :supervisor_remark, :form_second_id, :position)
    end
end
