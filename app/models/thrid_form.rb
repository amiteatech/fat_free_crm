class ThridForm < ApplicationRecord
  belongs_to :task
  has_many :thrid_form_histories
  
  after_save :create_history
  
	def create_history
		thrid_form_history = FormSecondHistory.new
		thrid_form_history.thrid_form_id = self.id
		thrid_form_history.task_id = self.task_id
		thrid_form_history.user_id = self.user_id
		thrid_form_history.module_title = self.module_title
		thrid_form_history.module_syllabus_no = self.module_syllabus_no
		thrid_form_history.course = self.course
		thrid_form_history.module_toucht_by = self.module_toucht_by
		thrid_form_history.relevent_information = self.relevent_information
		thrid_form_history.student_performance = self.student_performance
		thrid_form_history.evaluation = self.evaluation
		thrid_form_history.module_development = self.module_development
		thrid_form_history.module_development_submitted_by = self.module_development_submitted_by
		thrid_form_history.module_development_submitted_date = self.module_development_submitted_date
		thrid_form_history.comments = self.comments
		thrid_form_history.comments_name = self.comments_name
		thrid_form_history.comments_signature = self.comments_signature
		thrid_form_history.comments_designation = self.comments_designation
		thrid_form_history.comments_date = self.comments_date
		thrid_form_history.save
	end 	
end
