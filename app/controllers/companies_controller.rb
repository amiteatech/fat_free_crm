

class CompaniesController < ApplicationController
  skip_before_filter :checksuper_admin
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  layout "super"



  # GET /companies
  def index
    @search = Company.ransack(view_context.empty_blank_params params[:q])

    # if params[:csv].present?
    # @companies = @search.result(distinct: true)
    #                     .order("id DESC")
    # else  
    @companies = @search.result(distinct: true)
                        .order("id DESC")
                        
    # end  
    # @companies = Company.all
  end

  # GET /companies/1
  def show
    send_file(
        "#{Rails.root}/app/template/Op.xltx",
        filename: "a.xltx",
        type: "application/excel",
        disposition: 'inline'
       )   
   # send_file(data, type: 'application/vnd.ms-excel', filename: "#{uploaded_file.metadata["filename"]}", disposition: 'inline')
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  def create

    @company = Company.new(company_params)

    @user = User.new(user_params)

    if @company.save && @user.save(:validate => false)
       @user.update_attributes({:company_id =>  @company.id, :admin => true, :school_admin => true, :school_user => true})
      redirect_to companies_url, notice: 'Company was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      redirect_to companies_url, notice: 'Company was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /companies/1
  def destroy
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def company_params
      params.require(:company).permit(:name, :address1, :address2, :city, :country, :prime_contact, :prime_phone_number, :status)
    end
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :password)
    end
end
