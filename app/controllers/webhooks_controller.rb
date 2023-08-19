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
      render json: { message: 'test 1' }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      puts e.message
      render json: { message: 'test 2' }, status: 400
      return
    end

    case event.type
    when 'payment_intent.succeeded'

      render json: { message: 'success' }
    else
      render json: { message: 'else' }
    end
  end
end
