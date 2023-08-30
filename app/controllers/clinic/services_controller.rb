class Clinic::ServicesController < Clinic::BaseController
  before_action :get_service, only: %i[edit update show destroy]
  before_action :check_own, only: %i[edit update show destroy]

  def index
    @services = Service.where(clinic_profile_id: current_user.profile.clinic_profile.id)
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
      respond_to do |format|
        format.html { redirect_to clinic_services_path, notice: I18n.t('service.basic.create_success') }
        format.turbo_stream { render layout: false }
      end
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


  private

  def service_params
    params.require(:service).permit(
      :name,
      :description,
      :price,
      :service_wallpaper,
      :execution_time
    )
  end

  def get_service
    @service = Service.find_by(id: params[:id])
  end

  def check_own
    authorize [:clinic, @service]
  end
end
