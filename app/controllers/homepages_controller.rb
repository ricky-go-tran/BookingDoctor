class HomepagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :check_first_login
  layout "homepage_layout"

  def index
  end

  def clinics
  end

  def services
  end

  def doctors
  end

  def blogs
  end

  def supports
  end

  def direct
    if current_user.has_role? :admin
      redirect_to admin_profiles_index_path
    elsif current_user.has_role? :patient
      redirect_to patient_profiles_path
    elsif current_user.has_role? :clinic
      redirect_to clinic_profiles_path
    end
  end
end
