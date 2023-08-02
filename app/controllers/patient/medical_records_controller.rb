class Patient::MedicalRecordsController < Patient::BaseController
  def create
    @medical_record = MedicalRecord(medical_record_params)
    if @medical_record.save
      flash[:success] = 'Success! Register appointment'
      redirect_to "/clinics/#{@medical_record.clinic_profile_id}"
    else
      flash[:error] = "Error! Can't appointment! Please try again"
      redirect_to "/clinics/#{@medical_record.clinic_profile_id}"
    end
  end

  private

  def medical_record_params
    params.require(:medical_record).permit(:clinic_profile_id, :start_time, :end_time, :status, service_items_attributes: [:service_id])
  end
end
