require 'test_helper'

class TaskFormTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_form_tag = task_form_tags(:one)
  end

  test "should get index" do
    get task_form_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_task_form_tag_url
    assert_response :success
  end

  test "should create task_form_tag" do
    assert_difference('TaskFormTag.count') do
      post task_form_tags_url, params: { task_form_tag: { company_id: @task_form_tag.company_id, name: @task_form_tag.name, status: @task_form_tag.status } }
    end

    assert_redirected_to task_form_tag_url(TaskFormTag.last)
  end

  test "should show task_form_tag" do
    get task_form_tag_url(@task_form_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_form_tag_url(@task_form_tag)
    assert_response :success
  end

  test "should update task_form_tag" do
    patch task_form_tag_url(@task_form_tag), params: { task_form_tag: { company_id: @task_form_tag.company_id, name: @task_form_tag.name, status: @task_form_tag.status } }
    assert_redirected_to task_form_tag_url(@task_form_tag)
  end

  test "should destroy task_form_tag" do
    assert_difference('TaskFormTag.count', -1) do
      delete task_form_tag_url(@task_form_tag)
    end

    assert_redirected_to task_form_tags_url
  end
end
