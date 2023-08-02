# frozen_string_literal: true

class HomepagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :check_first_login
  layout 'homepage_layout'

  def index; end

  def clinics
    @categories = Category.all
    @clinics = ClinicProfile.joins(:profile).where("profiles.status = 'valid'")
  end

  def clinic_detail
    @clinic = ClinicProfile.find(params[:id])
    @profile = @clinic.profile
    @services = @clinic.services
  end

  def services
    @services = Service.all
  end

  def service_detail
    @service = Service.find(params[:id])
    @clinic = @service.clinic_profile
  end

  def supports; end

  def direct
    if current_user.has_role? :admin
      redirect_to admin_profiles_index_path
    elsif current_user.has_role? :patient
      redirect_to patient_profiles_path
    elsif current_user.has_role? :clinic
      redirect_to clinic_profiles_path
    end
  end

  def unauthorization; end

  def appointment
    @clinic = ClinicProfile.find(params[:id])
    @medical_record = @clinic.medical_records.build
    @medical_record.service_items.build
    @medical_record.service_items.build
    @medical_record.service_items.build
  end
end

private

def get_current_week; end
