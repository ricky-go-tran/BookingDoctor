# frozen_string_literal: true

class Admin::ProfilesController < Admin::BaseController
  before_action :get_profile, only: %i[update change]

  def index; end

  def update
    if @profile.update(profile_params)
      redirect_to admin_profiles_path, status: 303
    else
      render :change, status: 422
    end
  end

  def change; end

  def create; end

  def new; end

  def show; end

  private

  def profile_params
    params.require(:profile).permit(:fullname, :birthday, :address)
  end

  def get_profile
    @profile = Profile.find(current_user.profile.id)
  end
end
