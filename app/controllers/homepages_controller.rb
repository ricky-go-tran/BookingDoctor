# frozen_string_literal: true

class HomepagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :check_first_login
  layout 'homepage_layout'

  def index; end

  def clinics
    @categories = Category.all
    @pagy, @clinics = pagy(ClinicProfile.joins(:profile).where("profiles.status = 'valid'"), items: 10)
    if params[:search]
      @clinics = ClinicProfile.search(params[:search])
    elsif params[:type]
      @clinics = ClinicProfile.type(params[:type])
    end
    @clinic
  end

  def clinic_detail
    @clinic = ClinicProfile.find(params[:id])
    @profile = @clinic.profile
    @services = @clinic.services
    current_week = MedicalRecord.current_appointment_by_clinic(@clinic.id)
    @calendar_booking = []
    @calendar_booking = current_week.map do |item|
      booking = if user_signed_in? && current_user.has_role?(:patient) && current_user.profile.patient_profile.id == item.patient_profile_id
                  ChartItemCreator.call(1, 'Your booking', '#FE6B64', item.start_time, item.end_time)
                else
                  ChartItemCreator.call(2, 'Orther booking', '#B29DD9', item.start_time, item.end_time)
                end
      booking
    end
    @calendar_booking = @calendar_booking.to_json
  end

  def services
    @pagy, @services = pagy(Service.all, items: 10)
    if params[:search]
      @services = Service.search(params[:search])
    end
    @services
  end

  def service_detail
    @service = Service.find(params[:id])
    @clinic = @service.clinic_profile
  end

  def supports; end

  def direct
    if current_user.has_role? :admin
      redirect_to admin_profiles_path
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
