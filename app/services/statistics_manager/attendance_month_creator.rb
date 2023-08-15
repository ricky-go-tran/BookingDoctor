class StatisticsManager::AttendanceMonthCreator < ApplicationService
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def call
    start_of_month = Time.current.beginning_of_month
    end_of_month = Time.current.end_of_month

    attendances = MedicalRecord.current_month_finish(@user_id)
    attendance_by_day_in_month = {}
    date_range = (start_of_month.to_date..end_of_month.to_date).to_a
    date_range.each do |date|
      attendance_by_day_in_month[date.to_date] = 0
    end
    attendances.each do |attendance|
      day = attendance.created_at.to_date
      attendance_by_day_in_month[day] += 1
    end
    attendance_by_day_in_month
  end
end
