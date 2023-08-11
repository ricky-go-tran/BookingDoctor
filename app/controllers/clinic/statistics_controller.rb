class Clinic::StatisticsController < Clinic::BaseController
  def index
    @appointment = MedicalRecord.current_month(current_user.get_profile_clinic.id)
    @attendance = MedicalRecord.current_month_finish(current_user.get_profile_clinic.id)
    @cancle = MedicalRecord.current_month_cancel(current_user.get_profile_clinic.id)
    @appointment_prev = MedicalRecord.prev_month(current_user.get_profile_clinic.id)
    @attendance_prev = MedicalRecord.prev_month_finish(current_user.get_profile_clinic.id)
    @cancle_prev = MedicalRecord.prev_month_cancel(current_user.get_profile_clinic.id)
    @top5prescription = Inventory.top_5_in_month
    @top5service = Service.top_5_in_month(current_user.get_profile_clinic.id)

    @top5service = @top5service.map do |key, value|
      item = Service.find(key)
      item_hash = item.attributes.symbolize_keys
      item_hash[:count] = value
      item_hash
    end

    @attendance_json = get_attendance_month.to_json
    @appointment_json = get_appointment_month.to_json
    @cancle_json = get_cancle_month.to_json
  end

  private

  def get_attendance_month
    start_of_month = Time.current.beginning_of_month
    end_of_month = Time.current.end_of_month

    attendances = MedicalRecord.current_month_finish(current_user.get_profile_clinic.id)
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

    appointments = MedicalRecord.current_month(current_user.get_profile_clinic.id)
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

    cancles = MedicalRecord.current_month_cancel(current_user.get_profile_clinic.id)
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
