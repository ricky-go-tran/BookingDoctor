require 'test_helper'

class Clinic::StatisticsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get clinic_statistics_index_url
    assert_response :success
  end
end
