class Clinic::AppointmentsController < Clinic::BaseController
  before_action :get_medical_record, only: %i[show cancle progress]

  def index
    @medical_records = MedicalRecord.current_appointment_by_clinic(current_user.profile.clinic_profile.id)
    @medical_records_json = MedicalRecordsManager::MedicalRecordsJsonCreator.call(@medical_records)
    @medical_records_json = @medical_records_json.to_json
  end

  def detail; end

  def show; end

  def cancle
    if @medical_record.update(status: 'cancle')
      ActionCable
        .server
        .broadcast("notifications:#{@medical_record.clinic_profile.profile.user_id}",
                   { data: @medical_record.id, action: 'cancle' })
    end
  end

  def progress
    @progress_appointment = MedicalRecord.where(clinic_profile_id: current_user.get_profile_clinic.id, status: 'progress')
    if @medical_record.status != 'appointment'
      raise StandardError, I18n.t('medical_record.basic.status_invalid')
    elsif @progress_appointment.present?
      raise StandardError, I18n.t('medical_record.basic.progress_exist')
    else
      @medical_record.status = 'progress'
      @medical_record.save!
      redirect_to clinic_workspaces_path
    end
  rescue StandardError => e
    flash[:error_notice] = e.message
    redirect_to clinic_appointment_path(@medical_record)
  end

  private

  def get_medical_record
    @medical_record = MedicalRecord.find(params[:id])
  end
end
