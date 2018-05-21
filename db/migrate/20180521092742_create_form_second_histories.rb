class CreateFormSecondHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :form_second_histories do |t|
      t.integer :task_id
      t.string :name
      t.string :module_title
      t.string :course
      t.date :course_date
      t.integer :module_toucht_by_id
      t.integer :company_id
      t.integer :user_id
      t.integer :task_id
      t.string :week_1
      t.string :topic_1
      t.string :textbook_1
      t.string :teaching_activity_1
      t.string :teacher_remark_1
      t.string :supervisor_remark_1
      t.string :week_2
      t.string :topic_2
      t.string :textbook_2
      t.string :teaching_activity_2
      t.string :teacher_remark_2
      t.string :supervisor_remark_2
      t.string :week_3
      t.string :topic_3
      t.string :textbook_3
      t.string :teaching_activity_3
      t.string :teacher_remark_3
      t.string, :supervisor_remark_3
      t.string :week_4
      t.string :string,
      t.string :topic_4
      t.string :string,
      t.string :textbook_4
      t.string :string
      t.string :teaching_activity_4
      t.string :string
      t.string :teacher_remark_4
      t.string :supervisor_remark_4
      t.string :week_5
      t.string :topic_5
      t.string :textbook_5
      t.string :teaching_activity_5
      t.string :teacher_remark_5
      t.string :supervisor_remark_5

      t.timestamps
    end
  end
end
