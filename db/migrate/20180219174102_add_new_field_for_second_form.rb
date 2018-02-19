class AddNewFieldForSecondForm < ActiveRecord::Migration[5.0]
   def change
  	add_column :form_seconds, :week_1, :string
  	add_column :form_seconds, :topic_1, :string
  	add_column :form_seconds, :textbook_1, :string
  	add_column :form_seconds, :teaching_activity_1, :string
  	add_column :form_seconds, :teacher_remark_1, :string
  	add_column :form_seconds, :supervisor_remark_1, :string

  	add_column :form_seconds, :week_2, :string
  	add_column :form_seconds, :topic_2, :string
  	add_column :form_seconds, :textbook_2, :string
  	add_column :form_seconds, :teaching_activity_2, :string
  	add_column :form_seconds, :teacher_remark_2, :string
  	add_column :form_seconds, :supervisor_remark_2, :string

  	add_column :form_seconds, :week_3, :string
  	add_column :form_seconds, :topic_3, :string
  	add_column :form_seconds, :textbook_3, :string
  	add_column :form_seconds, :teaching_activity_3, :string
  	add_column :form_seconds, :teacher_remark_3, :string
  	add_column :form_seconds, :supervisor_remark_3, :string

  	add_column :form_seconds, :week_4, :string
  	add_column :form_seconds, :topic_4, :string
  	add_column :form_seconds, :textbook_4, :string
  	add_column :form_seconds, :teaching_activity_4, :string
  	add_column :form_seconds, :teacher_remark_4, :string
  	add_column :form_seconds, :supervisor_remark_4, :string

  	add_column :form_seconds, :week_5, :string
  	add_column :form_seconds, :topic_5, :string
  	add_column :form_seconds, :textbook_5, :string
  	add_column :form_seconds, :teaching_activity_5, :string
  	add_column :form_seconds, :teacher_remark_5, :string
  	add_column :form_seconds, :supervisor_remark_5, :string
  end
end


