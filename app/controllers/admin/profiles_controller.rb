# frozen_string_literal: true

module Admin
  class ProfilesController < Admin::BaseController
    def index; end

    def update
      @profile = Profile.find(current_user.profile.id)
      if @profile.update(profile_params)
        redirect_to admin_profiles_path
      else
        render :change, status: :unprocessable_entity
      end
    end

    def change
      @profile = Profile.find(current_user.profile.id)
    end

    def create; end

    def new; end

    def show; end

    private

    def profile_params
      params.require(:profile).permit(:fulname, :birthday, :address)
    end
  end
end
