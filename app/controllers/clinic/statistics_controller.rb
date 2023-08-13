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
    @top5service = ServicesManager::InsertCountAttributeCreator.call(@top5service)
    @attendance_json = StatisticsManager::AttendanceMonthCreator.call(current_user.get_profile_clinic.id).to_json
    @appointment_json = StatisticsManager::AppointmentMonthCreator.call(current_user.get_profile_clinic.id).to_json
    @cancle_json = StatisticsManager::CancleMonthCreator.call(current_user.get_profile_clinic.id).to_json
  end

  private

  def get_attendance_month; end
end
