class Clinic::ServicesController < Clinic::BaseController
  before_action :get_service, only: %i[edit update show destroy]

  def index
    @services = Service.all
    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="all_inventory.xlsx"'
        render xlsx: 'index', layout: false
      end
    end
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.clinic_profile = current_user.profile.clinic_profile
    if @service.save
      redirect_to clinic_services_path
    else
      render :new, status: 422
    end
  end

  def show; end

  def edit; end

  def update
    if @service.update(service_params)
      redirect_to clinic_services_path
    else
      render :edit, status: 422
    end
  end

  def destroy
    @service.destroy
    redirect_to clinic_inventories_path, status: 303
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :price, :execution_time)
  end

  def get_service
    @service = Service.find(params[:id])
  end
end
