require 'test_helper'

class Clinic::MedicalResourcesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get clinic_medical_resources_index_url
    assert_response :success
  end

  test 'should get show' do
    get clinic_medical_resources_show_url
    assert_response :success
  end
end
