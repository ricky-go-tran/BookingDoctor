class MedicalRecordsManager::MedicalRecordsJsonService < ApplicationService
  attr_reader :medical_records

  def initialize(medical_records)
    @medical_records = medical_records
  end

  def call
    @medical_records = @medical_records.map do |item|
      {
        id: item.id,
        clinic_profile_id: item.clinic_profile_id,
        patient_profile_id: item.patient_profile_id,
        patient_name: get_name_patient_by_patient_id(item.patient_profile_id),
        start_time: item.start_time,
        end_time: item.end_time
      }
    end
    @medical_records
  end

  private

  def get_name_patient_by_patient_id(patient_id)
    PatientProfile.find_by(id: patient_id).profile.fullname
  end
end
