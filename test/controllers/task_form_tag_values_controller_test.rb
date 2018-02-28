require 'test_helper'

class TaskFormTagValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_form_tag_value = task_form_tag_values(:one)
  end

  test "should get index" do
    get task_form_tag_values_url
    assert_response :success
  end

  test "should get new" do
    get new_task_form_tag_value_url
    assert_response :success
  end

  test "should create task_form_tag_value" do
    assert_difference('TaskFormTagValue.count') do
      post task_form_tag_values_url, params: { task_form_tag_value: { company_id: @task_form_tag_value.company_id, name: @task_form_tag_value.name, task_form_tag_id: @task_form_tag_value.task_form_tag_id } }
    end

    assert_redirected_to task_form_tag_value_url(TaskFormTagValue.last)
  end

  test "should show task_form_tag_value" do
    get task_form_tag_value_url(@task_form_tag_value)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_form_tag_value_url(@task_form_tag_value)
    assert_response :success
  end

  test "should update task_form_tag_value" do
    patch task_form_tag_value_url(@task_form_tag_value), params: { task_form_tag_value: { company_id: @task_form_tag_value.company_id, name: @task_form_tag_value.name, task_form_tag_id: @task_form_tag_value.task_form_tag_id } }
    assert_redirected_to task_form_tag_value_url(@task_form_tag_value)
  end

  test "should destroy task_form_tag_value" do
    assert_difference('TaskFormTagValue.count', -1) do
      delete task_form_tag_value_url(@task_form_tag_value)
    end

    assert_redirected_to task_form_tag_values_url
  end
end
