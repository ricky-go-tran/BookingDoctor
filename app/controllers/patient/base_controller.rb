class Patient::BaseController < ApplicationController
  before_action :require_patient
  before_action :check_patient_profile, unless: :devise_controller?


  protected
  def require_patient
    if !current_user.has_role? :patient
      redirect_to root_path
    end
  end

  def exist_patient_profile?
    if user_signed_in? && current_user.has_role?(:patient) && current_user.profile != nil && current_user.profile.patient_profile == nil
      return false
    end
    return true
  end

  def check_patient_profile
    if !exist_patient_profile?
      redirect_to new_patient_patient_profile_path
    end
  end


end
