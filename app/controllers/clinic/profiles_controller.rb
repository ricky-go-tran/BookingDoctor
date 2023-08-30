# frozen_string_literal: true

class Clinic::ProfilesController < Clinic::BaseController
  skip_before_action :check_valid_clinic, only: %i[invalid]
  before_action :get_profile, only: %i[change update]

  def index; end

  def detail; end

  def update
    if @profile.update(profile_params)
      redirect_to clinic_profiles_path
    else
      render :change, status: 422
    end
  end

  def change; end

  def destroy; end

  def invalid
    respond_to do |format|
      format.html { render layout: 'application' }
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:fullname, :birthday, :address)
  end

  def get_profile
    @profile = Profile.find(current_user.profile.id)
  end
end
