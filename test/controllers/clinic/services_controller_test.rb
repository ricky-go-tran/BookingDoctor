require "test_helper"

class Clinic::ServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clinic_services_index_url
    assert_response :success
  end

  test "should get new" do
    get clinic_services_new_url
    assert_response :success
  end

  test "should get create" do
    get clinic_services_create_url
    assert_response :success
  end

  test "should get show" do
    get clinic_services_show_url
    assert_response :success
  end

  test "should get edit" do
    get clinic_services_edit_url
    assert_response :success
  end

  test "should get update" do
    get clinic_services_update_url
    assert_response :success
  end
end
