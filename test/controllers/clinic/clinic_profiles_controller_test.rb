require "test_helper"

class Clinic::ClinicProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clinic_clinic_profiles_index_url
    assert_response :success
  end

  test "should get new" do
    get clinic_clinic_profiles_new_url
    assert_response :success
  end

  test "should get create" do
    get clinic_clinic_profiles_create_url
    assert_response :success
  end

  test "should get edit" do
    get clinic_clinic_profiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get clinic_clinic_profiles_update_url
    assert_response :success
  end
end
