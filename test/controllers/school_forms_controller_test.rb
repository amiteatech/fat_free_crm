require 'test_helper'

class SchoolFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @school_form = school_forms(:one)
  end

  test "should get index" do
    get school_forms_url
    assert_response :success
  end

  test "should get new" do
    get new_school_form_url
    assert_response :success
  end

  test "should create school_form" do
    assert_difference('SchoolForm.count') do
      post school_forms_url, params: { school_form: { company_id: @school_form.company_id, name: @school_form.name, users_id: @school_form.users_id } }
    end

    assert_redirected_to school_form_url(SchoolForm.last)
  end

  test "should show school_form" do
    get school_form_url(@school_form)
    assert_response :success
  end

  test "should get edit" do
    get edit_school_form_url(@school_form)
    assert_response :success
  end

  test "should update school_form" do
    patch school_form_url(@school_form), params: { school_form: { company_id: @school_form.company_id, name: @school_form.name, users_id: @school_form.users_id } }
    assert_redirected_to school_form_url(@school_form)
  end

  test "should destroy school_form" do
    assert_difference('SchoolForm.count', -1) do
      delete school_form_url(@school_form)
    end

    assert_redirected_to school_forms_url
  end
end
