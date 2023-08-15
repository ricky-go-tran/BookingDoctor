class MedicalRecordJsonCreator < ApplicationService
  attr_reader :medical_record

  def initialize(medical_record)
    @medical_record = medical_record
  end

  def call
    medical_record_json = {}
    medical_record_json[:id] = @medical_record.id
    medical_record_json[:clinic_profile_id] = @medical_record.clinic_profile_id
    medical_record_json[:patient_profile_id] = @medical_record.patient_profile_id
    medical_record_json[:patient_name] = get_name_patient_by_patient_id(@medical_record.patient_profile_id)
    medical_record_json[:start_time] = @medical_record.start_time
    medical_record_json[:end_time] = @medical_record.end_time
    medical_record_json
  end

  private

  def get_name_patient_by_patient_id(patient_id)
    PatientProfile.find_by(id: patient_id).profile.fullname
  end
end
