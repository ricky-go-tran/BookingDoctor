class Clinic::ClinicProfilesController < Clinic::BaseController
  skip_before_action :require_clinic, only: %i[create new]
  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  protected
  def clinic_profile_params
    params.require(:clinic_profile).permit()
  end
end
