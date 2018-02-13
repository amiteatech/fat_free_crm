require 'test_helper'

class FormFirstsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form_first = form_firsts(:one)
  end

  test "should get index" do
    get form_firsts_url
    assert_response :success
  end

  test "should get new" do
    get new_form_first_url
    assert_response :success
  end

  test "should create form_first" do
    assert_difference('FormFirst.count') do
      post form_firsts_url, params: { form_first: { company_id: @form_first.company_id, interviewer_comment_first: @form_first.interviewer_comment_first, interviewer_comment_others: @form_first.interviewer_comment_others, interviewer_comment_second: @form_first.interviewer_comment_second, interviewer_comments: @form_first.interviewer_comments, name: @form_first.name, name_of_applicant: @form_first.name_of_applicant, part_a_first_interview_date: @form_first.part_a_first_interview_date, part_b_first_interview_date: @form_first.part_b_first_interview_date, part_c_date: @form_first.part_c_date, part_c_name: @form_first.part_c_name, part_c_signature: @form_first.part_c_signature, position_applied_for: @form_first.position_applied_for, user_id: @form_first.user_id } }
    end

    assert_redirected_to form_first_url(FormFirst.last)
  end

  test "should show form_first" do
    get form_first_url(@form_first)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_first_url(@form_first)
    assert_response :success
  end

  test "should update form_first" do
    patch form_first_url(@form_first), params: { form_first: { company_id: @form_first.company_id, interviewer_comment_first: @form_first.interviewer_comment_first, interviewer_comment_others: @form_first.interviewer_comment_others, interviewer_comment_second: @form_first.interviewer_comment_second, interviewer_comments: @form_first.interviewer_comments, name: @form_first.name, name_of_applicant: @form_first.name_of_applicant, part_a_first_interview_date: @form_first.part_a_first_interview_date, part_b_first_interview_date: @form_first.part_b_first_interview_date, part_c_date: @form_first.part_c_date, part_c_name: @form_first.part_c_name, part_c_signature: @form_first.part_c_signature, position_applied_for: @form_first.position_applied_for, user_id: @form_first.user_id } }
    assert_redirected_to form_first_url(@form_first)
  end

  test "should destroy form_first" do
    assert_difference('FormFirst.count', -1) do
      delete form_first_url(@form_first)
    end

    assert_redirected_to form_firsts_url
  end
end
