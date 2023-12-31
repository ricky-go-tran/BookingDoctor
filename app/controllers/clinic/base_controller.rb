# frozen_string_literal: true

class Clinic::BaseController < ApplicationController
  before_action :require_clinic
  before_action :check_clinic_profiles, unless: :devise_controller?
  before_action :check_valid_clinic

  layout 'clinic_layout'

  private

  def require_clinic
    return if current_user.has_role? :clinic

    redirect_to root_path
  end

  def exist_clinic_profile?
    current_user.profile&.clinic_profile&.present?
  end

  def check_clinic_profiles
    return if exist_clinic_profile?

    redirect_to new_clinic_clinic_profile_path
  end

  def is_valid_clinic?
    current_user.has_role?(:clinic) && current_user.profile.status == 'valid'
  end

  def check_valid_clinic
    return if is_valid_clinic?

    redirect_to invalid_clinic_profiles_path
  end
end
