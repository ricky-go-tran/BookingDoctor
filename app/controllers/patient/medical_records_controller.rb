class Patient::MedicalRecordsController < Patient::BaseController
  def create
    @medical_record = MedicalRecord.new(medical_record_params)

    @medical_record.patient_profile_id = current_user.profile.patient_profile.id
    sum = 0
    @medical_record.service_items = @medical_record.service_items.map do |item|
      item.price = Service.get_price_by_id(item[:service_id])
      sum += Service.get_execution_time_by_id(item[:service_id])
      item
    end
    @medical_record.end_time = @medical_record.start_time + sum.minutes
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
    params.require(:medical_record).permit(:clinic_profile_id, :start_time, :status, service_items_attributes: [:id, :service_id, :_destroy])
  end
end
