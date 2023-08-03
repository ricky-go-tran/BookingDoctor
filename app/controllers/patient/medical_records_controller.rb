class Patient::MedicalRecordsController < Patient::BaseController
  def index
    @medical_records = MedicalRecord.where(patient_profile_id: current_user.profile.patient_profile.id)
  end

  def show
    @medical_record = MedicalRecord.find(params[:id])
  end

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
      flash[:success_notice] = 'Success! Register appointment'
    else
      flash[:error_notice] = "Error! Can't appointment! Please try again"
    end
    redirect_to "/clinics/#{@medical_record.clinic_profile_id}"
  end

  def cancle
    @medical_record = MedicalRecord.find(params[:id])
    if @medical_record.update(status: 'cancle')
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
end
