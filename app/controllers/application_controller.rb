# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :check_first_login, unless: :devise_controller?

  include Pundit::Authorization
  include Pagy::Backend

  private

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
    direct_by_role(resource)
  end

  def direct_by_role(resource)
    if resource.has_role? :admin
      admin_profiles_path
    elsif resource.has_role? :patient
      patient_profiles_path
    elsif resource.has_role? :clinic
      clinic_profiles_path
    end
  end

  def is_first_login?
    user_signed_in? && current_user.profile.nil?
  end

  def first_login
    if current_user.has_role? :admin
      redirect_to new_admin_profile_path
    elsif current_user.has_role? :patient
      redirect_to new_patient_profile_path
    elsif current_user.has_role? :clinic
      redirect_to new_clinic_profile_path
    end
  end

  def check_first_login
    return unless is_first_login?

    first_login
  end
end
