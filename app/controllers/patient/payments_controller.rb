class Patient::PaymentsController < Patient::BaseController
  before_action :get_medical_record, only: %i[checkout payment payment_intent]
  def index
    @medical_records = MedicalRecord.where(patient_profile_id: current_user.get_profile_patient.id, status: 'payment')
    @medical_records_json = @medical_records.map do |item|
      {
        id: item.id,
        clinic_name: item.clinic_profile.name,
        start_time: item.start_time,
        end_time: item.end_time
      }
    end
    @medical_records_json = @medical_records_json.to_json
  end

  def new; end

  def payment
    @total = helpers.total_price(@medical_record.service_items, @medical_record.prescription_items)
    @customer_id = current_user.get_profile_patient.stripe_id
    @invoice = []
    @medical_record.service_items.each do |item|
      temp = {}
      temp[:name] = item.service.name
      temp[:type] = 'Service'
      temp[:price] = item.price
      @invoice.push(temp)
    end
    @medical_record.prescription_items.each do |item|
      temp = {}
      temp[:name] = item.medical_resource.name
      temp[:type] = 'Medicine'
      temp[:price] = (item.price * item.amount)
      @invoice.push(temp)
    end
  end

  def payment_intent
    if @medical_record.save
      flash[:success_notice] = 'Wait! Please wait process...'
    else
      flash[:error_notice] = 'Fail! Payment is fail!'
    end
    redirect_to payment_patient_payment_path(@medical_record)
  end

  private

  def substract_inventory(medical_record)
    subtract_prescription_items(medical_record.prescription_items)
    subtract_service_items(medical_record.service_items)
  end

  def subtract_prescription_items(prescription_items)
    prescription_items.each do |item|
      subtract_prescription_item(item.medical_resource_id, item.amount)
    end
  end

  def subtract_service_items(service_items)
    service_items.each do |item|
      subtract_service_item(item.service_id)
    end
  end

  def subtract_prescription_item(medical_id, consumtion_amount)
    inventory_item = Inventory.find_by(medical_resource_id: medical_id)
    if inventory_item.amount >= consumtion_amount
      inventory_item.amount -= consumtion_amount
      inventory_item.save
    else
      raise StandardError, 'Error! Amount is invalid'
    end
  end

  def subtract_service_item(service_id)
    services = Consumption.where(service_id:)
    services.each do |item|
      subtract_prescription_item(item.medical_resource_id, item.amount)
    end
  end

  def medical_record_update_params
    params.require(:medical_records).permit(:stripe_payment_id)
  end

  def get_medical_record
    @medical_record = MedicalRecord.find(params[:id])
  end
end
