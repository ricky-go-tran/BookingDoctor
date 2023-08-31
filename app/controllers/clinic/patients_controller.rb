class Clinic::PatientsController < Clinic::BaseController
  before_action :get_medical_records_by_patient, only: %i[show]
  before_action :get_medical_record, only: %i[detail_medical_record]

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

  def detail_medical_record
    @patient_profile = @medical_record.patient_profile
    @profile = @patient_profile.profile
    @examination = @medical_record.examination_resul
  end

  private

  def get_medical_record
    @medical_record = MedicalRecord.find_by(id: params[:id])
  end

  def get_medical_records_by_patient
    @patient = PatientProfile.find_by(id: params[:id])
    @medical_records = MedicalRecord.where(patient_profile_id: params[:id])
  end
end
