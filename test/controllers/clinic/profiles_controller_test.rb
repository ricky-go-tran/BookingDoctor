# frozen_string_literal: true

require 'test_helper'

module Clinic
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    test 'should get homepage' do
      get clinic_profiles_homepage_url
      assert_response :success
    end

    test 'should get index' do
      get clinic_profiles_index_url
      assert_response :success
    end

    test 'should get show' do
      get clinic_profiles_show_url
      assert_response :success
    end

    test 'should get update' do
      get clinic_profiles_update_url
      assert_response :success
    end

    test 'should get edit' do
      get clinic_profiles_edit_url
      assert_response :success
    end

    test 'should get destroy' do
      get clinic_profiles_destroy_url
      assert_response :success
    end

    test 'should get create' do
      get clinic_profiles_create_url
      assert_response :success
    end

    test 'should get new' do
      get clinic_profiles_new_url
      assert_response :success
    end
  end
end
