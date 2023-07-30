# frozen_string_literal: true

class Patien::BaseController < ApplicationController
  before_action :require_patient
  before_action :check_patient_profile, unless: :devise_controller?
  layout 'patient_layout'

  private

  def require_patient
    return if current_user.has_role? :patient

    redirect_to root_path
  end

  def exist_patient_profile?
    !(user_signed_in? && current_user.has_role?(:patient) && !current_user.profile.nil? && current_user.profile.patient_profile.nil?)
  end

  def check_patient_profile
    return if exist_patient_profile?

    redirect_to new_patient_patient_profile_path
  end
end
