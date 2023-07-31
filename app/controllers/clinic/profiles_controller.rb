# frozen_string_literal: true

class Clinic::ProfilesController < Clinic::BaseController
  skip_before_action :check_valid_clinic, only: %i[invalid]
  def index; end

  def detail; end

  def update
    @profile = Profile.find(current_user.profile.id)
    if @profile.update(profile_params)
      redirect_to clinic_profiles_path
    else
      render :change, status: 422
    end
  end

  def change
    @profile = Profile.find(current_user.profile.id)
  end

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
end
