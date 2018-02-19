require 'test_helper'

class ThridFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @thrid_form = thrid_forms(:one)
  end

  test "should get index" do
    get thrid_forms_url
    assert_response :success
  end

  test "should get new" do
    get new_thrid_form_url
    assert_response :success
  end

  test "should create thrid_form" do
    assert_difference('ThridForm.count') do
      post thrid_forms_url, params: { thrid_form: { comments: @thrid_form.comments, comments_date: @thrid_form.comments_date, comments_designation: @thrid_form.comments_designation, comments_name: @thrid_form.comments_name, comments_signature: @thrid_form.comments_signature, course: @thrid_form.course, evaluation: @thrid_form.evaluation, module_development: @thrid_form.module_development, module_development_submitted_by: @thrid_form.module_development_submitted_by, module_development_submitted_date: @thrid_form.module_development_submitted_date, module_syllabus_no: @thrid_form.module_syllabus_no, module_title: @thrid_form.module_title, module_toucht_by: @thrid_form.module_toucht_by, relevent_information: @thrid_form.relevent_information, student_performance: @thrid_form.student_performance, task_id: @thrid_form.task_id } }
    end

    assert_redirected_to thrid_form_url(ThridForm.last)
  end

  test "should show thrid_form" do
    get thrid_form_url(@thrid_form)
    assert_response :success
  end

  test "should get edit" do
    get edit_thrid_form_url(@thrid_form)
    assert_response :success
  end

  test "should update thrid_form" do
    patch thrid_form_url(@thrid_form), params: { thrid_form: { comments: @thrid_form.comments, comments_date: @thrid_form.comments_date, comments_designation: @thrid_form.comments_designation, comments_name: @thrid_form.comments_name, comments_signature: @thrid_form.comments_signature, course: @thrid_form.course, evaluation: @thrid_form.evaluation, module_development: @thrid_form.module_development, module_development_submitted_by: @thrid_form.module_development_submitted_by, module_development_submitted_date: @thrid_form.module_development_submitted_date, module_syllabus_no: @thrid_form.module_syllabus_no, module_title: @thrid_form.module_title, module_toucht_by: @thrid_form.module_toucht_by, relevent_information: @thrid_form.relevent_information, student_performance: @thrid_form.student_performance, task_id: @thrid_form.task_id } }
    assert_redirected_to thrid_form_url(@thrid_form)
  end

  test "should destroy thrid_form" do
    assert_difference('ThridForm.count', -1) do
      delete thrid_form_url(@thrid_form)
    end

    assert_redirected_to thrid_forms_url
  end
end
