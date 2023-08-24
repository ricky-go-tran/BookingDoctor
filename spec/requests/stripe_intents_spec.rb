require 'rails_helper'
require 'rack/test'
require 'pry-rails'

RSpec.describe 'StripeIntents', type: :request do
  describe 'POST #create' do
    it 'create payment intent' do
      params = {
        amount: 100,
        currency: 'usd',
        description: 'description'
      }
      post(stripe_intents_path, params:)
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response).to include('id', 'client_secret')
    end
  end
  describe 'GET #retrieve' do
    it 'get payment intent by id' do
      params = {
        stripe_payment_id: 'pi_3NhoZBJD1fB4LR0q1xs1Rlx6'
      }
      get(retrieve_stripe_intents_path, params:)
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response).to include('id', 'client_secret')
    end
    it 'get payment intent by id fails' do
      params = {
        stripe_payment_id: 'pi_3NhoZBJD1fB324567f'
      }
      get(retrieve_stripe_intents_path, params:)
      json_response = JSON.parse(response.body)
      expect(json_response).to include('error')
    end
  end
end
