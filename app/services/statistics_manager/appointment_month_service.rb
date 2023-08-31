class StatisticsManager::AppointmentMonthService < ApplicationService
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def call
    start_of_month = Time.current.beginning_of_month
    end_of_month = Time.current.end_of_month

    appointments = MedicalRecord.current_month(@user_id)
    appointment_by_day_in_month = {}
    date_range = (start_of_month.to_date..end_of_month.to_date).to_a
    date_range.each do |date|
      appointment_by_day_in_month[date.to_date] = 0
    end
    appointments.each do |appointment|
      day = appointment.created_at.to_date
      appointment_by_day_in_month[day] += 1
    end
    appointment_by_day_in_month
  end
end
