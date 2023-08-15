class Clinic::MedicalResourcesController < Clinic::BaseController
  def index
    @medical_resources = MedicalResource.all
    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="all_medical_resources.xlsx"'
        render xlsx: 'index', layout: false
      end
    end
  end

  def show
    @medical_resource = MedicalResource.find(params[:id])
    @inventory = Inventory.new
  end
end
