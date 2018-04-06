require 'test_helper'

class AccessOnFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @access_on_form = access_on_forms(:one)
  end

  test "should get index" do
    get access_on_forms_url
    assert_response :success
  end

  test "should get new" do
    get new_access_on_form_url
    assert_response :success
  end

  test "should create access_on_form" do
    assert_difference('AccessOnForm.count') do
      post access_on_forms_url, params: { access_on_form: { company_id: @access_on_form.company_id, school_form_id: @access_on_form.school_form_id, users_id: @access_on_form.users_id } }
    end

    assert_redirected_to access_on_form_url(AccessOnForm.last)
  end

  test "should show access_on_form" do
    get access_on_form_url(@access_on_form)
    assert_response :success
  end

  test "should get edit" do
    get edit_access_on_form_url(@access_on_form)
    assert_response :success
  end

  test "should update access_on_form" do
    patch access_on_form_url(@access_on_form), params: { access_on_form: { company_id: @access_on_form.company_id, school_form_id: @access_on_form.school_form_id, users_id: @access_on_form.users_id } }
    assert_redirected_to access_on_form_url(@access_on_form)
  end

  test "should destroy access_on_form" do
    assert_difference('AccessOnForm.count', -1) do
      delete access_on_form_url(@access_on_form)
    end

    assert_redirected_to access_on_forms_url
  end
end
