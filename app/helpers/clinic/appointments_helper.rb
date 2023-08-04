module Clinic::AppointmentsHelper
  def get_name_patient_by_patient_id(patient_id)
    PatientProfile.find_by(id: patient_id).profile.fullname
  end
end
