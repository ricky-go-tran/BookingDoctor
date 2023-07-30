class Clinic::StatisticsController < Clinic::BaseController
  def index
    @appointment = MedicalRecord.current_month
    @attendance = MedicalRecord.current_month_finish
    @cancle = MedicalRecord.current_month_cancel
    @appointment_prev = MedicalRecord.prev_month
    @attendance_prev = MedicalRecord.prev_month_finish
    @cancle_prev = MedicalRecord.prev_month_cancel
    @top5prescription = Inventory.top_5_in_month
    @top5service = Service.top_5_in_month
    @attendance_json = get_attendance_month.to_json
    @appointment_json = get_appointment_month.to_json
    @cancle_json = get_cancle_month.to_json
  end

  private

  def get_attendance_month
    start_of_month = Time.current.beginning_of_month
    end_of_month = Time.current.end_of_month

    attendances = MedicalRecord.current_month_finish
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

  def get_appointment_month
    start_of_month = Time.current.beginning_of_month
    end_of_month = Time.current.end_of_month

    appointments = MedicalRecord.current_month
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

  def get_cancle_month
    start_of_month = Time.current.beginning_of_month
    end_of_month = Time.current.end_of_month

    cancles = MedicalRecord.current_month_cancel
    cancle_by_day_in_month = {}
    date_range = (start_of_month.to_date..end_of_month.to_date).to_a
    date_range.each do |date|
      cancle_by_day_in_month[date.to_date] = 0
    end
    cancles.each do |cancle|
      day = cancle.created_at.to_date
      cancle_by_day_in_month[day] += 1
    end
    cancle_by_day_in_month
  end
end
