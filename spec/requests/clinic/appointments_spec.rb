require 'rails_helper'
require 'pry-rails'

RSpec.describe 'Clinic::Appointments', type: :request do
  context 'not login' do
    describe 'GET /index' do
      it 'appointments index not login' do
        get clinic_appointments_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe 'GET /new' do
      it 'appointments new not login' do
        get new_clinic_service_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe 'GET /edit' do
      it 'appointments edit not login' do
        get edit_clinic_service_path(:service)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe 'GET /show' do
      it 'appointments index not login' do
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
      it 'appointment index login' do
        sign_in @user
        get clinic_appointments_path
        expect(response).to_not redirect_to(new_user_session_path)
      end
    end
  end
end
