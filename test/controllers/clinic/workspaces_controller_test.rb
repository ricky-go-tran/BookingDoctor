require "test_helper"

class Clinic::WorkspacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clinic_workspaces_index_url
    assert_response :success
  end
end
