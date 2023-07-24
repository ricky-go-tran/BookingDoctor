class Patient::PatientProfilesController < Patient::BaseController
  skip_before_action :check_patient_profile, only: %i[new create]
  def homepage
  end

  def show
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def new

  end

  def create

  end
end
