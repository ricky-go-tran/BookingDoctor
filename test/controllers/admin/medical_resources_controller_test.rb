require "test_helper"

class Admin::MedicalResourcesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_medical_resources_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_medical_resources_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_medical_resources_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_medical_resources_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_medical_resources_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_medical_resources_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_medical_resources_destroy_url
    assert_response :success
  end
end
