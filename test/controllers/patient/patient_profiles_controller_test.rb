# frozen_string_literal: true

require 'test_helper'

module Patient
  class PatientProfilesControllerTest < ActionDispatch::IntegrationTest
    test 'should get homepage' do
      get patient_patient_profiles_homepage_url
      assert_response :success
    end

    test 'should get show' do
      get patient_patient_profiles_show_url
      assert_response :success
    end

    test 'should get update' do
      get patient_patient_profiles_update_url
      assert_response :success
    end

    test 'should get edit' do
      get patient_patient_profiles_edit_url
      assert_response :success
    end

    test 'should get destroy' do
      get patient_patient_profiles_destroy_url
      assert_response :success
    end
  end
end
