class SchoolItemNumbersController < ApplicationController
  before_action :set_school_item_number, only: [:show, :edit, :update, :destroy]

  # GET /school_item_numbers
  def index
    @school_item_numbers = SchoolItemNumber.all
  end

  # GET /school_item_numbers/1
  def show
  end

  # GET /school_item_numbers/new
  def new
    @school_item_number = SchoolItemNumber.new
  end

  # GET /school_item_numbers/1/edit
  def edit
  end

  # POST /school_item_numbers
  def create
    @school_item_number = SchoolItemNumber.new(school_item_number_params)
    @school_item_number.company_id = current_user.company_id
    if @school_item_number.save
      redirect_to school_item_numbers_url, notice: 'School item number was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /school_item_numbers/1
  def update
    if @school_item_number.update(school_item_number_params)
       @school_item_number.company_id = current_user.company_id
        @school_item_number.save
      redirect_to school_item_numbers_url, notice: 'School item number was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /school_item_numbers/1
  def destroy
    @school_item_number.update_attribute("status",false)
    redirect_to school_item_numbers_url, notice: 'School item number was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_item_number
      @school_item_number = SchoolItemNumber.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def school_item_number_params
      params.require(:school_item_number).permit(:name, :status)
    end
end
