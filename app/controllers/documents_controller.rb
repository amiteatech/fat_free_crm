class DocumentsController < ApplicationController
	before_action :set_school_folder, only: [:show, :edit, :update, :destroy]
  def index
  	if current_user.is_super_admin?
  		@folders = SchoolFolder.all
  	elsif current_user.is_admin?
  		@folders = SchoolFolder.all.where(company_id: current_user.company_id)
  	else
  		school_folders = []
  		SchoolFolder.all.where(company_id: current_user.company_id).each do |school_folder|
		  	school_folder.school_files.each do |school_file|
		  		if current_user.groups.present?
		  			current_user.groups.each do |group|
		  				if school_file.groups.include?(group.id.to_s)
		  					school_folders << school_folder
		  				end
		  			end
		  		end
		  	end
		  	@folders = SchoolFolder.where(id: school_folders)
		  end
  	end
  end

  def show
  	# @school_files = @school_folder.
  	if current_user.is_super_admin? || current_user.is_admin?
  		@school_files = @school_folder.school_files
  	else
  		file_ids = []
	  	@school_folder.school_files.each do |school_file|
	  		if current_user.groups.present?
	  			current_user.groups.each do |group|
	  				if school_file.groups.include?(group.id.to_s)
	  					file_ids << school_file.id
	  				end
	  			end
	  		end
	  	end
	  	@school_files = SchoolFile.where(id: file_ids)
	  end
  end

  def new
  	@school_folder = SchoolFolder.new
  end

  def edit

  end

  def create
  	# dir = File.dirname("#{Rails.root}/public/uploads/#{current_user.company_id}/#{school_folder_params[:name]}")
  	# path = FileUtils.mkdir_p(dir) unless File.directory?(dir)
  	# path = FileUtils::mkdir_p Dir.home+"/CRM/"+ "#{current_user.company_id}" +"/"+school_folder_params[:name]
  	if school_folder_params[:name] == "" || !params[:groups].present? || !params[:school_file].present?
  		@school_folder = SchoolFolder.new
		  redirect_to new_document_path, notice: 'Something went wrong with form submission. Please try again!'
  	else
	  	if SchoolFolder.where(company_id: current_user.company_id).where(name: school_folder_params[:name]).empty?
	  		@school_folder = SchoolFolder.new(school_folder_params)

		    if @school_folder.save
		    	@school_folder.update_attributes(company_id: current_user.company_id)
		    	if params[:school_file].present?
		    		@school_file = SchoolFile.new
		    		@school_file.avatar = params[:school_file]
		    		@school_file.school_folder_id = @school_folder.id
		    		if params[:groups].present?
				      params[:groups].each do |group|
				      	@school_file.groups << group
				      end
				    end 
		    		@school_file.save
		    	end
		      redirect_to documents_path, notice: 'Folder was successfully created.'
		    else
		      render :new
		    end
		  else
		  	@school_folder = SchoolFolder.new
		  	redirect_to new_document_path, notice: 'Folder already exist.'
	  	end 
	  end
  end

  def update
    
  end

  def update_files
  	@school_folder = SchoolFolder.find(params[:id])
  	if school_folder_params[:name] == "" || !params[:groups].present? || !params[:school_file].present?
		  redirect_to edit_document_path(@school_folder), notice: 'Something went wrong in form submission. Please try again!'
  	else
	  	if @school_folder.update(school_folder_params)
	    	if params[:school_file].present?
	    		@school_file = SchoolFile.new
	    		@school_file.avatar = params[:school_file]
	    		@school_file.school_folder_id = @school_folder.id
	    		if params[:groups].present?
			      params[:groups].each do |group|
			      	unless @school_file.groups.include?(group)
			      		@school_file.groups << group
			      	end
			      end
			    end 
	    		@school_file.save
	    	end
	      redirect_to document_path(@school_folder), notice: 'File was successfully added.'
	    else
	      render :edit
	    end
	  end
  end

  def destroy
  	@school_folder.destroy
    redirect_to documents_path, notice: 'Folder was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_folder
      @school_folder = SchoolFolder.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def school_folder_params
      params.require(:school_folder).permit(:name, :company_id, :path)
    end
end
