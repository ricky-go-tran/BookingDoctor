require "test_helper"

class Patient::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get homepage" do
    get patient_profiles_homepage_url
    assert_response :success
  end

  test "should get index" do
    get patient_profiles_index_url
    assert_response :success
  end

  test "should get show" do
    get patient_profiles_show_url
    assert_response :success
  end

  test "should get update" do
    get patient_profiles_update_url
    assert_response :success
  end

  test "should get edit" do
    get patient_profiles_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get patient_profiles_destroy_url
    assert_response :success
  end

  test "should get create" do
    get patient_profiles_create_url
    assert_response :success
  end

  test "should get new" do
    get patient_profiles_new_url
    assert_response :success
  end
end
