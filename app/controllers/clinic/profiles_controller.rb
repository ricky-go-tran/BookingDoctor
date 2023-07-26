# frozen_string_literal: true

module Clinic
  class ProfilesController < Clinic::BaseController
    skip_before_action :check_valid_clinic, only: %i[invalid]
    def index; end

    def detail; end

    def update
      @profile = Profile.find(current_user.profile.id)
      if @profile.update(profile_params)
        redirect_to clinic_profiles_path
      else
        render :change, status: :unprocessable_entity
      end
    end

    def change
      @profile = Profile.find(current_user.profile.id)
    end

    def destroy; end
    def invalid; end

    private

    def profile_params
      params.require(:profile).permit(:fullname, :birthday, :address)
    end
  end
end
