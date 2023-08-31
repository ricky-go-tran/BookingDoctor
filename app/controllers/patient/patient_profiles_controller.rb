# frozen_string_literal: true

class Patient::PatientProfilesController < Patient::BaseController
  skip_before_action :check_patient_profile, only: %i[new create]

  def homepage; end

  def show; end

  def update
    @patient_profile = current_user.profile.patient_profile
    if @patient_profile.update(patient_profile_params)
      flash[:success_notice] = I18n.t('profile.change_success')
      redirect_to patient_profiles_path
    else
      flash[:error_notice] = I18n.t('profile.change_error')
      render :change, status: 422, layout: false
    end
  end

  def change
    @patient_profile = current_user.profile.patient_profile
  end

  def destroy; end

  def new
    @patient_profile = PatientProfile.new
    respond_to do |format|
      format.html { render layout: 'application' }
    end
  end

  def create
    @patient_profile = PatientProfile.new(patient_profile_params)
    @patient_profile.profile_id = current_user.profile.id
    if @patient_profile.save
      redirect_to patient_profiles_path
    else
      render :new, status: 422
    end
  end

  protected

  def patient_profile_params
    params.require(:patient_profile).permit(:height, :weight, :blood_group, :drug_allergy)
  end

  def check_exist_profile_profiles
    return unless exist_patient_profile?

    redirect_to patient_profiles_path
  end
end
