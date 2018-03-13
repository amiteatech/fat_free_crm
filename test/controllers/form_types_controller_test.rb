require 'test_helper'

class FormTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form_type = form_types(:one)
  end

  test "should get index" do
    get form_types_url
    assert_response :success
  end

  test "should get new" do
    get new_form_type_url
    assert_response :success
  end

  test "should create form_type" do
    assert_difference('FormType.count') do
      post form_types_url, params: { form_type: { company_id: @form_type.company_id, name: @form_type.name, status: @form_type.status } }
    end

    assert_redirected_to form_type_url(FormType.last)
  end

  test "should show form_type" do
    get form_type_url(@form_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_type_url(@form_type)
    assert_response :success
  end

  test "should update form_type" do
    patch form_type_url(@form_type), params: { form_type: { company_id: @form_type.company_id, name: @form_type.name, status: @form_type.status } }
    assert_redirected_to form_type_url(@form_type)
  end

  test "should destroy form_type" do
    assert_difference('FormType.count', -1) do
      delete form_type_url(@form_type)
    end

    assert_redirected_to form_types_url
  end
end
