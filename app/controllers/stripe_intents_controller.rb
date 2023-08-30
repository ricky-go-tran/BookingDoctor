class StripeIntentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    payment_intent = Stripe::PaymentIntent.create(
      amount: params[:amount].to_i,
      currency: params[:currency],
      description: params[:desciption],
      customer: params[:customer]
    )
    render json: {
      id: payment_intent.id,
      client_secret: payment_intent.client_secret
    }
  end

  def retrieve
    payment_intent = Stripe::PaymentIntent.retrieve(
      params[:stripe_payment_id]
    )
    render json: {
      id: payment_intent.id,
      client_secret: payment_intent.client_secret
    }
  end

  def update_medical_record
    @medical_record = MedicalRecord.find(params[:medical_record_id])
    @medical_record.stripe_payment_id = params[:stripe_payment_id]
    if @medical_record.save
      render json: {
        status: 'success'
      }
    else
      render json: {
        status: 'fail'
      }
    end
  end

  private

  def payment_params
    params.permit(:amount, :currency, :description, :customer, stripe_intent: [:amount, :currency, :description, :customer])
  end

  def retrieve_params
    params.permit(stripe_intent: [:stripe_payment_id])
  end

  def update_medical_record_params
    params.permit(stripe_intent: [:medical_record_id, :stripe_payment_id])
  end
end
