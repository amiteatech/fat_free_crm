require 'test_helper'

class SupplementaryTaskFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supplementary_task_file = supplementary_task_files(:one)
  end

  test "should get index" do
    get supplementary_task_files_url
    assert_response :success
  end

  test "should get new" do
    get new_supplementary_task_file_url
    assert_response :success
  end

  test "should create supplementary_task_file" do
    assert_difference('SupplementaryTaskFile.count') do
      post supplementary_task_files_url, params: { supplementary_task_file: { name: @supplementary_task_file.name, task_id: @supplementary_task_file.task_id } }
    end

    assert_redirected_to supplementary_task_file_url(SupplementaryTaskFile.last)
  end

  test "should show supplementary_task_file" do
    get supplementary_task_file_url(@supplementary_task_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_supplementary_task_file_url(@supplementary_task_file)
    assert_response :success
  end

  test "should update supplementary_task_file" do
    patch supplementary_task_file_url(@supplementary_task_file), params: { supplementary_task_file: { name: @supplementary_task_file.name, task_id: @supplementary_task_file.task_id } }
    assert_redirected_to supplementary_task_file_url(@supplementary_task_file)
  end

  test "should destroy supplementary_task_file" do
    assert_difference('SupplementaryTaskFile.count', -1) do
      delete supplementary_task_file_url(@supplementary_task_file)
    end

    assert_redirected_to supplementary_task_files_url
  end
end
