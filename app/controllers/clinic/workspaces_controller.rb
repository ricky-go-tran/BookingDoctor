class Clinic::WorkspacesController < Clinic::BaseController
  def index
    @medical_record = MedicalRecord.get_current_progess_in_clinic(current_user.profile.clinic_profile.id)
  end
end
