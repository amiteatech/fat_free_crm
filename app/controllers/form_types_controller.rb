class FormTypesController < ApplicationController
  before_action :set_form_type, only: [:show, :edit, :update, :destroy]

  # GET /form_types
  def index
    @form_types = FormType.all
  end

  # GET /form_types/1
  def show
  end

  # GET /form_types/new
  def new
    @form_type = FormType.new
  end

  # GET /form_types/1/edit
  def edit
  end

  # POST /form_types
  def create
    @form_type = FormType.new(form_type_params)

    if @form_type.save
      redirect_to form_types_url, notice: 'Form type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /form_types/1
  def update
    if @form_type.update(form_type_params)
      redirect_to form_types_url, notice: 'Form type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /form_types/1
  def destroy
    @form_type.destroy
    redirect_to form_types_url, notice: 'Form type was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_type
      @form_type = FormType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def form_type_params
      params.require(:form_type).permit(:name, :status, :company_id)
    end
end
