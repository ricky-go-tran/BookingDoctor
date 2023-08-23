# frozen_string_literal: true

class Clinic::ClinicProfilesController < Clinic::BaseController
  skip_before_action :require_clinic, only: %i[create new]
  skip_before_action :check_clinic_profiles, only: %i[create new]
  before_action :check_exist_clinic_profiles, only: %i[create new]
  skip_before_action :check_valid_clinic, only: %i[create new]
  before_action :get_clinic_profile, only: %i[change update]

  def new
    @clinic_profile = ClinicProfile.new
    respond_to do |format|
      format.html { render layout: 'application' }
    end
  end

  def create
    @clinic_profile = ClinicProfile.new(clinic_profile_params)
    @clinic_profile.profile_id = current_user.profile.id
    @profile = Profile.find(current_user.profile.id)

    @profile.status = 'invalid'
    if @clinic_profile.save
      if @profile.save
        current_user.delete_roles
        current_user.add_role :clinic
        redirect_to root_path
      end
    else
      render :new, status: 422, layout: 'application'
    end
  end

  def change; end

  def update
    if @clinic_profile.update(clinic_profile_params)
      @profile = Profile.find(current_user.profile.id)
      @profile.update(status: 'invalid')

      redirect_to clinic_profiles_path
    else
      render :change, status: 422
    end
  end

  private

  def clinic_profile_params
    params.require(:clinic_profile).permit(:category_id, :name, :address, :phone, :description, :start_hour, :end_hour,
                                           :start_day, :end_day, :certificate, :clinic_view)
  end

  def get_clinic_profile
    @clinic_profile = ClinicProfile.find(current_user.profile.clinic_profile.id)
  end

  def check_exist_clinic_profiles
    return unless exist_clinic_profile?

    redirect_to root_path
  end
end
