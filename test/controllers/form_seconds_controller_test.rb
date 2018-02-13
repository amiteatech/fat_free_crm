require 'test_helper'

class FormSecondsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form_second = form_seconds(:one)
  end

  test "should get index" do
    get form_seconds_url
    assert_response :success
  end

  test "should get new" do
    get new_form_second_url
    assert_response :success
  end

  test "should create form_second" do
    assert_difference('FormSecond.count') do
      post form_seconds_url, params: { form_second: { company_id: @form_second.company_id, course: @form_second.course, course_date: @form_second.course_date, module_title: @form_second.module_title, module_toucht_by_id: @form_second.module_toucht_by_id, name: @form_second.name, task_id: @form_second.task_id, user_id: @form_second.user_id } }
    end

    assert_redirected_to form_second_url(FormSecond.last)
  end

  test "should show form_second" do
    get form_second_url(@form_second)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_second_url(@form_second)
    assert_response :success
  end

  test "should update form_second" do
    patch form_second_url(@form_second), params: { form_second: { company_id: @form_second.company_id, course: @form_second.course, course_date: @form_second.course_date, module_title: @form_second.module_title, module_toucht_by_id: @form_second.module_toucht_by_id, name: @form_second.name, task_id: @form_second.task_id, user_id: @form_second.user_id } }
    assert_redirected_to form_second_url(@form_second)
  end

  test "should destroy form_second" do
    assert_difference('FormSecond.count', -1) do
      delete form_second_url(@form_second)
    end

    assert_redirected_to form_seconds_url
  end
end
