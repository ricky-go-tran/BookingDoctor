class Clinic::PaymentsController < Clinic::BaseController
  def pay
    @medical_record = MedicalRecord.find_by(id: params[:id])
    @total = helpers.total_price(@medical_record.service_items, @medical_record.prescription_items)
    @payment_intent = Stripe::PaymentIntent.create(
      {
        amount: @total,
        currency: 'usd',
        automatic_payment_methods: { enabled: true },
        description: "Order #{@medical_record.id}"
      }
    )
  end
end
