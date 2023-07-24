class Admin::MedicalResourcesController < ApplicationController
  layout "admin_layout"
  def index
    if params[:search]
      @medical_resources = MedicalResource.where("UPPER(name) LIKE UPPER(?)", "%#{params[:search]}%")
    else
      @medical_resources = MedicalResource.all
    end
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="all_medical_resources.xlsx"'
        render xlsx: "index", layout: false
      }
    end
  end

  def show
    @medical_resource = MedicalResource.find(params[:id])
  end


  def new
    @medical_resource = MedicalResource.new
  end

  def create
    @medical_resource = MedicalResource.new(medical_resource_params)
    if @medical_resource.save
      redirect_to admin_medical_resources_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @medical_resource = MedicalResource.find(params[:id])
  end

  def update
    @medical_resource = MedicalResource.find(params[:id])
    if @medical_resource.update(medical_resource_params)
      redirect_to admin_medical_resources_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @medical_resource = MedicalResource.find(params[:id])
    @medical_resource.destroy
    redirect_to admin_categories_path, status: :see_other
  end

  private
  def medical_resource_params
    params.require(:medical_resource).permit(:name, :brand, :unit, :desciption, :type)
  end
end