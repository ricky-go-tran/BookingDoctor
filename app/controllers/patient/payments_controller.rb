class Patient::PaymentsController < Patient::BaseController
  def index
    @medical_records = MedicalRecord.where(patient_profile_id: current_user.get_profile_patient.id, status: 'payment')
  end

  def new; end

  def checkout
    @medical_record = MedicalRecord.find(params[:id])
    list = []
    @medical_record.prescription_items.each do |item|
      list.push({ price: item.price, quantity: item.amount })
    end
    @medical_record.service_items.each do |item|
      list.push({ price: item.price, quantity: 1 })
    end
    session = Stripe::Checkout::Session.create(
      {
        line_items: [{
          price: 'price_1234',
          quantity: 1
        }],
        mode: 'payment',
        customer: current_user.profile.patient_profile.stripe_id,
        client_reference_id: @medical_record.id,
        success_url: success_patient_payment_path(id: @medical_record.id),
        cancel_url: cancle_patient_payment_path(id: @medical_record.id)
      }
    )
    redirect_to session.url
  end

  def success
    @medical_record = MedicalRecord.find(params[:id])
    @medical_record.status = 'finish'
    if @medical_record.save
      flash[:success_notice] = 'Success! Payment invoice!'
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
end
