require 'test_helper'

class FormSecondDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form_second_detail = form_second_details(:one)
  end

  test "should get index" do
    get form_second_details_url
    assert_response :success
  end

  test "should get new" do
    get new_form_second_detail_url
    assert_response :success
  end

  test "should create form_second_detail" do
    assert_difference('FormSecondDetail.count') do
      post form_second_details_url, params: { form_second_detail: { form_second_id: @form_second_detail.form_second_id, position: @form_second_detail.position, supervisor_remark: @form_second_detail.supervisor_remark, teacher_remark: @form_second_detail.teacher_remark, teaching_activity: @form_second_detail.teaching_activity, textbook: @form_second_detail.textbook, topic: @form_second_detail.topic, week: @form_second_detail.week } }
    end

    assert_redirected_to form_second_detail_url(FormSecondDetail.last)
  end

  test "should show form_second_detail" do
    get form_second_detail_url(@form_second_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_second_detail_url(@form_second_detail)
    assert_response :success
  end

  test "should update form_second_detail" do
    patch form_second_detail_url(@form_second_detail), params: { form_second_detail: { form_second_id: @form_second_detail.form_second_id, position: @form_second_detail.position, supervisor_remark: @form_second_detail.supervisor_remark, teacher_remark: @form_second_detail.teacher_remark, teaching_activity: @form_second_detail.teaching_activity, textbook: @form_second_detail.textbook, topic: @form_second_detail.topic, week: @form_second_detail.week } }
    assert_redirected_to form_second_detail_url(@form_second_detail)
  end

  test "should destroy form_second_detail" do
    assert_difference('FormSecondDetail.count', -1) do
      delete form_second_detail_url(@form_second_detail)
    end

    assert_redirected_to form_second_details_url
  end
end
