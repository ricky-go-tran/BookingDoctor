class Patient::PaymentsController < Patient::BaseController
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

  def checkout
    @medical_record = MedicalRecord.find(params[:id])
    list = PrescriptionItemJsonCreator.call(@medical_record.prescription_items)
    list.concat(ServiceItemJsonCreator.call(@medical_record.service_items))

    session = Stripe::Checkout::Session.create(
      {
        line_items: list,
        mode: 'payment',
        customer: current_user.profile.patient_profile.stripe_id,
        client_reference_id: @medical_record.id,
        success_url: "http://localhost:3000/patient/payments/#{@medical_record.id}/success",
        cancel_url: "http://localhost:3000/patient/payments/#{@medical_record.id}/cancel"
      }
    )
    redirect_to session.url, allow_other_host: true
  rescue Stripe::CardError => e
    flash[:error_notice] = e.message
    redirect_to patient_payments_path
  end

  def success
    @medical_record = MedicalRecord.find(params[:id])
    @medical_record.status = 'finish'
    if @medical_record.save
      substract_inventory(@medical_record)
      flash[:success_notice] = 'Success! Payment invoice!'
      ActionCable
        .server
        .broadcast("finpays:#{@medical_record.clinic_profile.profile.user_id}",
                   { data: @medical_record.id, action: 'redirect' })
      redirect_to patient_payments_path
    else
      flash[:error_notice] = 'Fail! Payment invoice!'
      redirect_to patient_payments_path
    end
  end

  def cancle
    flash[:error_notice] = 'Fail! Payment invoice!'
    redirect_to patient_payments_path
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
    inventory_item = Inventory.find(medical_id)
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
end
