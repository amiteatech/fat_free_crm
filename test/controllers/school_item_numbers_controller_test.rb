require 'test_helper'

class SchoolItemNumbersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @school_item_number = school_item_numbers(:one)
  end

  test "should get index" do
    get school_item_numbers_url
    assert_response :success
  end

  test "should get new" do
    get new_school_item_number_url
    assert_response :success
  end

  test "should create school_item_number" do
    assert_difference('SchoolItemNumber.count') do
      post school_item_numbers_url, params: { school_item_number: { name: @school_item_number.name, status: @school_item_number.status } }
    end

    assert_redirected_to school_item_number_url(SchoolItemNumber.last)
  end

  test "should show school_item_number" do
    get school_item_number_url(@school_item_number)
    assert_response :success
  end

  test "should get edit" do
    get edit_school_item_number_url(@school_item_number)
    assert_response :success
  end

  test "should update school_item_number" do
    patch school_item_number_url(@school_item_number), params: { school_item_number: { name: @school_item_number.name, status: @school_item_number.status } }
    assert_redirected_to school_item_number_url(@school_item_number)
  end

  test "should destroy school_item_number" do
    assert_difference('SchoolItemNumber.count', -1) do
      delete school_item_number_url(@school_item_number)
    end

    assert_redirected_to school_item_numbers_url
  end
end
