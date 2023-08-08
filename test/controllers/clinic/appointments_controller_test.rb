require "test_helper"

class Clinic::AppointmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clinic_appointments_index_url
    assert_response :success
  end

  test "should get detail" do
    get clinic_appointments_detail_url
    assert_response :success
  end
end
