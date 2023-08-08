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
    current_week = MedicalRecord.current_appointment_by_clinic(@clinic.id)
    @calendar_booking = []
    @calendar_booking = current_week.map do |item|
      booking = {}
      booking[:start] = item.start_time
      booking[:end] = item.end_time
      if user_signed_in? && current_user.profile.patient_profile.id == item.patient_profile_id
        booking[:resourceId] = 1
        booking[:title] = 'Your booking'
        booking[:color] = '#FE6B64'
      else
        booking[:resourceId] = 2
        booking[:title] = 'Other booking'
        booking[:color] = '#B29DD9'
      end
      booking
    end
    @calendar_booking = @calendar_booking.to_json
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
  end
end
