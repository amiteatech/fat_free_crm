require 'test_helper'

class TaskFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_file = task_files(:one)
  end

  test "should get index" do
    get task_files_url
    assert_response :success
  end

  test "should get new" do
    get new_task_file_url
    assert_response :success
  end

  test "should create task_file" do
    assert_difference('TaskFile.count') do
      post task_files_url, params: { task_file: { name: @task_file.name, task_id: @task_file.task_id } }
    end

    assert_redirected_to task_file_url(TaskFile.last)
  end

  test "should show task_file" do
    get task_file_url(@task_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_file_url(@task_file)
    assert_response :success
  end

  test "should update task_file" do
    patch task_file_url(@task_file), params: { task_file: { name: @task_file.name, task_id: @task_file.task_id } }
    assert_redirected_to task_file_url(@task_file)
  end

  test "should destroy task_file" do
    assert_difference('TaskFile.count', -1) do
      delete task_file_url(@task_file)
    end

    assert_redirected_to task_files_url
  end
end
