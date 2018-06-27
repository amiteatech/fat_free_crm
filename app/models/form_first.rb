class FormFirst < ApplicationRecord
  belongs_to :task
  has_many :form_first_histories

  after_save :create_history
  
  def create_history
  	 form_first_history = FormFirstHistory.new
  	 form_first_history.form_first_id = self.id
     form_first_history.name = self.name
     form_first_history.part_b_name = self.part_b_name
     form_first_history.name_of_applicant = self.name_of_applicant
     form_first_history.position_applied_for =  self.position_applied_for
     form_first_history.part_a_first_interview_date = self.part_a_first_interview_date
     form_first_history.interviewer_comment_first = self.interviewer_comment_first
     form_first_history.interviewer_comment_second = self.interviewer_comment_second
     form_first_history.interviewer_comment_others = self.interviewer_comment_others
     form_first_history.part_b_first_interview_date = self.part_b_first_interview_date
     form_first_history.interviewer_comments = self.interviewer_comments
     form_first_history.part_c_name = self.part_c_name
     form_first_history.part_c_signature = self.part_c_signature
     form_first_history.part_c_date = self.part_c_date
     form_first_history.company_id = self.company_id
     form_first_history.user_id = self.user_id
     form_first_history.task_id = self.task_id
     form_first_history.part_c_name_1 = self.part_c_name_1
     form_first_history.part_c_signatur_1 = self.part_c_signatur_1
     form_first_history.part_c_date_1 = self.part_c_date_1
     form_first_history.part_c_name_2 = self.part_c_name_2
     form_first_history.part_c_signatur_2 = self.part_c_signatur_2
     form_first_history.part_c_date_2 = self.part_c_date_2
     form_first_history.save
  end

end
