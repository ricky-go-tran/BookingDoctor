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
    @patient_profile = PatientProfile.new
    respond_to do |format|
      format.html { render layout: "application" }
    end
  end

  def create
    @patient_profile = PatientProfile.new(patient_profile_params)
    @patient_profile.profile_id = current_user.profile.id
    if @patient_profile.save
      redirect_to patient_profiles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  protected

  def patient_profile_params
    params.require(:patient_profile).permit(:height, :weight, :blood_group, :drug_allergy)
  end
end
