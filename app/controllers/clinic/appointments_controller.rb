class Clinic::AppointmentsController < Clinic::BaseController
  def index
    @medical_records = MedicalRecord.current_appointment_by_clinic(current_user.profile.clinic_profile.id)

    @medical_records_json = @medical_records.map do |item|
      {
        id: item.id,
        clinic_profile_id: item.clinic_profile_id,
        patient_profile_id: item.patient_profile_id,
        patient_name: helpers.get_name_patient_by_patient_id(item.patient_profile_id),
        start_time: item.start_time,
        end_time: item.end_time
      }
    end
    @medical_records_json = @medical_records_json.to_json
  end

  def detail; end

  def show
    @medical_record = MedicalRecord.find(params[:id])
  end

  def cancle
    @medical_record = MedicalRecord.find(params[:id])
    if @medical_record.update(status: 'cancle')
      ActionCable
        .server
        .broadcast("notifications:#{@medical_record.clinic_profile.profile.user_id}",
                   { data: @medical_record.id, action: 'cancle' })
    end
  end
end
