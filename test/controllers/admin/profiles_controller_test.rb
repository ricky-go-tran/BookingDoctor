# frozen_string_literal: true

require 'test_helper'

module Admin
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    test 'should get homepage' do
      get admin_profiles_homepage_url
      assert_response :success
    end

    test 'should get index' do
      get admin_profiles_index_url
      assert_response :success
    end

    test 'should get show' do
      get admin_profiles_show_url
      assert_response :success
    end

    test 'should get update' do
      get admin_profiles_update_url
      assert_response :success
    end

    test 'should get edit' do
      get admin_profiles_edit_url
      assert_response :success
    end

    test 'should get destroy' do
      get admin_profiles_destroy_url
      assert_response :success
    end

    test 'should get create' do
      get admin_profiles_create_url
      assert_response :success
    end

    test 'should get new' do
      get admin_profiles_new_url
      assert_response :success
    end
  end
end
