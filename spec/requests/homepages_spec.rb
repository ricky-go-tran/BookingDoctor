require 'rails_helper'
require 'byebug'
require 'pry-rails'

RSpec.describe 'Homepages', type: :request do
  describe 'GET /index' do
    it 'homepage index' do
      get homepages_path
      expect(response).to have_http_status(200)
    end
    it 'homepage index without login' do
      get homepages_path
      expect(response).to_not match(/Welcome/)
    end
  end
  describe 'GET /clinics' do
    it 'clinics view' do
      get clinics_homepages_path
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET /services' do
    it 'clinics view' do
      get services_homepages_path
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET /clinics detail' do
    it 'clinics detail exist' do
      get '/clinics/1'
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET /services detail ' do
    it 'services detail exist' do
      get '/services/1'
      expect(response).to have_http_status(200)
    end
  end
end
