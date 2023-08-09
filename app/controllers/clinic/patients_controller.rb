class Clinic::PatientsController < Clinic::BaseController
  def index
    @patients = PatientProfile.get_patients_of_clinics(current_user.get_profile_clinic.id)
    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="all_patient.xlsx"'
        render xlsx: 'index', layout: false
      end
    end
  end

  def show; end
end
