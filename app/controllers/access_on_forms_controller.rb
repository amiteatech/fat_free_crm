class AccessOnFormsController < ApplicationController
  before_action :set_access_on_form, only: [:show, :edit, :update, :destroy]

  # GET /access_on_forms
  def index
    if current_user.is_super_admin?
      @access_on_forms = AccessOnForm.all
    else
      @access_on_forms = AccessOnForm.where(company_id: current_user.company_id)
    end
  end

  # GET /access_on_forms/1
  def show
  end

  # GET /access_on_forms/new
  def new
    @access_on_form = AccessOnForm.new
  end

  # GET /access_on_forms/1/edit
  def edit
  end

  # POST /access_on_forms
  def create
    @access_on_form = AccessOnForm.new
    users = User.joins(:groups).where("groups.id" => params["users"]).uniq  
    
    if AccessOnForm.where(company_id: current_user.company_id).where(school_form_id: params["school_form_id"]).present?
      redirect_to @access_on_form, notice: 'Access on this form was already created.'
    else
      @access_on_form.school_form_id = params["school_form_id"]
      @access_on_form.company_id = current_user.company_id
      if users.present?
        users_id = users.map{|d|d.id}
        @access_on_form.users_id = users_id
      end

      if @access_on_form.save
        redirect_to @access_on_form, notice: 'Access on form was successfully created.'
      else
        render :new
      end
    end

  end

  # PATCH/PUT /access_on_forms/1
  def update
    if @access_on_form
      # @access_on_form.school_form_id = params["school_form_id"]
      users = User.joins(:groups).where("groups.id" => params["users"]).uniq
      if users.present?
        users_id = users.map{|d|d.id}
        @access_on_form.users_id = users_id
      end  
      @access_on_form.save
      redirect_to @access_on_form, notice: 'Access on form was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /access_on_forms/1
  def destroy
    @access_on_form.destroy
    redirect_to access_on_forms_url, notice: 'Access on form was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access_on_form
      @access_on_form = AccessOnForm.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def access_on_form_params
      #params.require(:access_on_form).permit(:school_form_id, :users)
      params.require(:access_on_form).permit!
    end
end
