require 'test_helper'

class TaskYearsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_year = task_years(:one)
  end

  test "should get index" do
    get task_years_url
    assert_response :success
  end

  test "should get new" do
    get new_task_year_url
    assert_response :success
  end

  test "should create task_year" do
    assert_difference('TaskYear.count') do
      post task_years_url, params: { task_year: { company_id: @task_year.company_id, name: @task_year.name, status: @task_year.status } }
    end

    assert_redirected_to task_year_url(TaskYear.last)
  end

  test "should show task_year" do
    get task_year_url(@task_year)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_year_url(@task_year)
    assert_response :success
  end

  test "should update task_year" do
    patch task_year_url(@task_year), params: { task_year: { company_id: @task_year.company_id, name: @task_year.name, status: @task_year.status } }
    assert_redirected_to task_year_url(@task_year)
  end

  test "should destroy task_year" do
    assert_difference('TaskYear.count', -1) do
      delete task_year_url(@task_year)
    end

    assert_redirected_to task_years_url
  end
end
