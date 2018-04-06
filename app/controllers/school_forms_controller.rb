class SchoolFormsController < ApplicationController
  before_action :set_school_form, only: [:show, :edit, :update, :destroy]

  # GET /school_forms
  def index
    @school_forms = SchoolForm.all
  end

  # GET /school_forms/1
  def show
  end

  # GET /school_forms/new
  def new
    @school_form = SchoolForm.new
  end

  # GET /school_forms/1/edit
  def edit
  end

  # POST /school_forms
  def create
    @school_form = SchoolForm.new(school_form_params)

    if @school_form.save
      redirect_to @school_form, notice: 'School form was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /school_forms/1
  def update
    if @school_form.update(school_form_params)
      redirect_to @school_form, notice: 'School form was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /school_forms/1
  def destroy
    @school_form.destroy
    redirect_to school_forms_url, notice: 'School form was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_form
      @school_form = SchoolForm.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def school_form_params
      params.require(:school_form).permit(:name, :company_id, :users_id)
    end
end
