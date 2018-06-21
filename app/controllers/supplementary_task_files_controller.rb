class SupplementaryTaskFilesController < ApplicationController
  before_action :set_supplementary_task_file, only: [:show, :edit, :update, :destroy]

  # GET /supplementary_task_files
  def index
    @supplementary_task_files = SupplementaryTaskFile.all
  end

  # GET /supplementary_task_files/1
  def show
  end

  # GET /supplementary_task_files/new
  def new
    @supplementary_task_file = SupplementaryTaskFile.new
  end

  # GET /supplementary_task_files/1/edit
  def edit
  end

  # POST /supplementary_task_files
  def create
    @supplementary_task_file = SupplementaryTaskFile.new(supplementary_task_file_params)

    if @supplementary_task_file.save
      redirect_to @supplementary_task_file, notice: 'Supplementary task file was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /supplementary_task_files/1
  def update
    if @supplementary_task_file.update(supplementary_task_file_params)
      redirect_to @supplementary_task_file, notice: 'Supplementary task file was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /supplementary_task_files/1
  def destroy
    @supplementary_task_file.destroy
    redirect_to :back, notice: 'Supplementary task file was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplementary_task_file
      @supplementary_task_file = SupplementaryTaskFile.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def supplementary_task_file_params
      params.require(:supplementary_task_file).permit(:name, :task_id)
    end
end
