# frozen_string_literal: true

module Clinic
  class BaseController < ApplicationController
    before_action :require_clinic
    before_action :check_clinic_profiles, unless: :devise_controller?
    before_action :check_valid_clinic

    protected

    def require_clinic
      return if current_user.has_role? :clinic

      redirect_to root_path
    end

    def exist_clinic_profile?
      if user_signed_in? && current_user.has_role?(:clinic) && !current_user.profile.nil? && current_user.profile.clinic_profile.nil?
        return false
      end

      true
    end

    def check_clinic_profiles
      return if exist_clinic_profile?

      redirect_to new_clinic_clinic_profile_path
    end

    def is_valid_clinic?
      return true if current_user.has_role?(:clinic) && current_user.profile.status == 'valid'

      false
    end

    def check_valid_clinic
      return if is_valid_clinic?

      redirect_to invalid_clinic_profiles_path
    end
  end
end
