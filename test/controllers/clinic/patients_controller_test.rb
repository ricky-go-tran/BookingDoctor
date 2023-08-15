require "test_helper"

class Clinic::PatientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clinic_patients_index_url
    assert_response :success
  end

  test "should get show" do
    get clinic_patients_show_url
    assert_response :success
  end
end
