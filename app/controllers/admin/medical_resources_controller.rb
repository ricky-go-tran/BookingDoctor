class Admin::MedicalResourcesController < Admin::BaseController
  before_action :get_medical_resource, only: %i[show edit update destroy]
  def index
    @medical_resources = if params[:search]
                           MedicalResource.search(params[:search])
                         else
                           MedicalResource.all
                         end
    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="all_medical_resources.xlsx"'
        render xlsx: 'index', layout: false
      end
    end
  end

  def show; end

  def new
    @medical_resource = MedicalResource.new
  end

  def create
    @medical_resource = MedicalResource.new(medical_resource_params)
    if @medical_resource.save
      redirect_to admin_medical_resources_path
    else
      render :new, status: 422
    end
  end

  def edit; end

  def update
    if @medical_resource.update(medical_resource_params)
      redirect_to admin_medical_resources_path
    else
      render :edit, status: 422
    end
  end

  def destroy
    @medical_resource.destroy
    redirect_to admin_categories_path, status: 303
  end

  private

  def medical_resource_params
    params.require(:medical_resource).permit(:name, :brand, :unit, :description, :medical_resource_type)
  end

  def get_medical_resource
    @medical_resource = MedicalResource.find(params[:id])
  end
end
