require 'test_helper'

class PdfsControllerTest < ActionDispatch::IntegrationTest
  test 'should get invoice' do
    get pdfs_invoice_url
    assert_response :success
  end
end
