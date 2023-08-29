class Patient::MedicalRecordsController < Patient::BaseController
  before_action :get_medical_record, only: %i[show cancle]
  before_action :check_own, only: %i[show cancle]
  def index
    @medical_records = MedicalRecord.where(patient_profile_id: current_user.profile.patient_profile.id)
  end

  def show; end

  def create
    @medical_record = MedicalRecord.new(medical_record_params)
    if @medical_record.service_items.empty?
      flash[:error_notice] = "Error! Service can't empty! Please try again"
      redirect_to(clinics_homepages_path(@medical_record.clinic_profile_id))
    else
      @medical_record.patient_profile_id = current_user.profile.patient_profile.id
      @medical_record.end_time = MedicalRecordsManager::CalculatorEndTimeCreator.call(@medical_record)
      if @medical_record.save
        medical_record_json = MedicalRecordJsonCreator.call(@medical_record)
        ActionCable
          .server
          .broadcast("notifications:#{@medical_record.clinic_profile.profile.user_id}",
                     { data: medical_record_json, action: 'add' })
        booking = ChartItemCreator.call(1, 'Your booking', '#FE6B64', @medical_record.start_time, @medical_record.end_time)
        ActionCable
          .server
          .broadcast('calendars_channel',
                     { data: booking, action: 'add' })
        CanclePastAppointmentWorker.perform_at(@medical_record.start_time, @medical_record.to_json)
        flash[:success_notice] = 'Success! Register appointment'
      else
        flash[:error_notice] = "Error! Can't appointment! Please try again"
      end
      redirect_to "/clinics/#{@medical_record.clinic_profile_id}"
    end
  end

  def cancle
    if @medical_record.update(status: 'cancle')
      ActionCable
        .server
        .broadcast("notifications:#{@medical_record.clinic_profile.profile.user_id}",
                   { data: @medical_record.id, action: 'cancle' })
      flash[:success_notice] = 'Success! Cancle appointment'
    else
      flash[:error_notice] = 'Fail! Can\'t cancle appointment! Try again!'
    end
    redirect_to patient_medical_records_path
  end

  private

  def medical_record_params
    params.require(:medical_record).permit(:clinic_profile_id, :start_time, :status, service_items_attributes: [:id, :service_id, :_destroy])
  end

  def get_medical_record
    @medical_record = MedicalRecord.find(params[:id])
  end

  def check_own
    authorize [:patient, @medical_record]
  end
end
