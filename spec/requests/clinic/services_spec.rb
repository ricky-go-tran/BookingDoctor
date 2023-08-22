require 'rails_helper'
require 'pry-rails'

RSpec.describe 'Clinic::Services', type: :request do
  let(:user) { create(:user) }
  context 'not login' do
    describe 'GET /index' do
      it 'services index not login' do
        get clinic_services_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe 'GET /new' do
      it 'services new not login' do
        get new_clinic_service_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe 'GET /edit' do
      it 'services edit not login' do
        get edit_clinic_service_path(:service)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe 'GET /show' do
      it 'services index not login' do
        get clinic_service_path(:service)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  context 'login' do
    before do
      @user = create(:user)
      @category = create(:category)
      @profile = create(:profile, user_id: @user.id)
      @clinic_profile = create(:clinic_profile, profile_id: @profile.id, category_id: @category.id)
      @user.delete_roles
      @user.add_role :clinic
    end
    describe 'GET /index' do
      it 'services index login' do
        sign_in @user
        get clinic_services_path
        expect(response).to_not redirect_to(new_user_session_path)
      end
    end
    describe 'GET /new' do
      it 'services new login' do
        sign_in @user
        get new_clinic_service_path
        expect(response).to_not redirect_to(new_user_session_path)
      end
    end
  end
end
