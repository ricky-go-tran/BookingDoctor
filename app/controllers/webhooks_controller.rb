class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil
    endpoint_secret = Rails.application.credentials.webhook_serect
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      puts e.message
      render json: { message: 'ParserError' }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      puts e.message
      render json: { message: 'SignatureVerificationError', data: e.message }, status: 400
      return
    end

    case event.type
    when 'payment_intent.succeeded'
      payment_intent = event.data.object
      @medical_record = MedicalRecord.find_by(stripe_payment_id: payment_intent.id)
      @medical_record.status = 'finish'
      if @medical_record.save
        substract_inventory(@medical_record)
        flash[:success_notice] = 'Success! Payment invoice!'
        ActionCable
          .server
          .broadcast("finpays:#{@medical_record.clinic_profile.profile.user_id}",
                     { data: @medical_record.id, action: 'redirect' })
      else
        flash[:error_notice] = 'Fail! Payment invoice!'
      end
      redirect_to patient_payments_path
    else
      render json: { message: 'else' }
    end
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
end
