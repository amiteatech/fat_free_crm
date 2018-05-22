require 'test_helper'

class SurperTaskReportControllerTest < ActionDispatch::IntegrationTest
  test "should get task_super" do
    get surper_task_report_task_super_url
    assert_response :success
  end

  test "should get report_super" do
    get surper_task_report_report_super_url
    assert_response :success
  end

end
