require "test_helper"

class Clinic::PdfsControllerTest < ActionDispatch::IntegrationTest
  test "should get invoiceprescription" do
    get clinic_pdfs_invoiceprescription_url
    assert_response :success
  end
end
