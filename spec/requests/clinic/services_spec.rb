require 'rails_helper'

RSpec.describe 'Clinic::Services', type: :request do
  describe 'GET /index' do
    it 'services index not login' do
      get clinic_services_path
      expect(response).to have_http_status(302)
    end
  end
end
