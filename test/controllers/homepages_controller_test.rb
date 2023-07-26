# frozen_string_literal: true

require 'test_helper'

class HomepagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get homepages_index_url
    assert_response :success
  end

  test 'should get clinics' do
    get homepages_clinics_url
    assert_response :success
  end

  test 'should get services' do
    get homepages_services_url
    assert_response :success
  end

  test 'should get doctors' do
    get homepages_doctors_url
    assert_response :success
  end

  test 'should get blogs' do
    get homepages_blogs_url
    assert_response :success
  end

  test 'should get supports' do
    get homepages_supports_url
    assert_response :success
  end
end
