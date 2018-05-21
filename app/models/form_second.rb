class FormSecond < ApplicationRecord
  belongs_to :task	
  has_many :form_second_histories
  
  after_save :create_history
  
 

    def create_history
      form_second_history = FormSecondHistory.new 
      form_second_history.form_second_id = self.id
      form_second_history.name = self.name
      form_second_history.module_title = self.module_title
      form_second_history.course = self.course
      form_second_history.course_date = self.course_date
      form_second_history.module_toucht_by_id = self.module_toucht_by_id
      form_second_history.company_id = self.company_id
      form_second_history.user_id = self.company_id
      form_second_history.company_id = self.company_id
      form_second_history.week_1 = self.week_1
      form_second_history.topic_1 = self.topic_1
      form_second_history.textbook_1 = self.textbook_1
      form_second_history.teaching_activity_1 = self.teaching_activity_1
      form_second_history.teacher_remark_1 = self.teacher_remark_1
      form_second_history.supervisor_remark_1 = self.supervisor_remark_1
      form_second_history.week_2 = self.week_2
      form_second_history.topic_2 = self.topic_2
      form_second_history.textbook_2 = self.textbook_2
      form_second_history.teaching_activity_2 = self.teaching_activity_2
      form_second_history.teacher_remark_2 = self.teacher_remark_2
      form_second_history.supervisor_remark_2 = self.supervisor_remark_2
      form_second_history.week_3 = self.week_3
      form_second_history.topic_3 = self.topic_3
      form_second_history.textbook_3 = self.textbook_3
      form_second_history.teaching_activity_3 = self.teaching_activity_3
      form_second_history.teacher_remark_3 = self.teacher_remark_3
      form_second_history.supervisor_remark_3 = self.supervisor_remark_3
      form_second_history.week_4 = self.week_4
      form_second_history.topic_4 = self.week_4
      form_second_history.textbook_4 = self.textbook_4
      form_second_history.teaching_activity_4 = self.teaching_activity_4
      form_second_history.teacher_remark_4 = self.teacher_remark_4
      form_second_history.supervisor_remark_4 = self.supervisor_remark_4
      form_second_history.week_5 = self.week_5
      form_second_history.topic_5 = self.topic_5
      form_second_history.textbook_5 = self.textbook_5
      form_second_history.teaching_activity_5 = self.teaching_activity_5
      form_second_history.teacher_remark_5 = self.teacher_remark_5
      form_second_history.supervisor_remark_5 = self.supervisor_remark_5
      form_first_history.save
  end
end
