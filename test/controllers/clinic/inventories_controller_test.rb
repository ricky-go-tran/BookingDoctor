require 'test_helper'

class Clinic::InventoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get clinic_inventories_index_url
    assert_response :success
  end

  test 'should get show' do
    get clinic_inventories_show_url
    assert_response :success
  end

  test 'should get new' do
    get clinic_inventories_new_url
    assert_response :success
  end

  test 'should get create' do
    get clinic_inventories_create_url
    assert_response :success
  end

  test 'should get edit' do
    get clinic_inventories_edit_url
    assert_response :success
  end

  test 'should get update' do
    get clinic_inventories_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get clinic_inventories_destroy_url
    assert_response :success
  end
end
