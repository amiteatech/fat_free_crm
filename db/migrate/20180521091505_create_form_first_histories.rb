class CreateFormFirstHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :form_first_histories do |t|
      t.integer :form_first_id
      t.string :name
      t.string :name_of_applicant
      t.string :position_applied_for
      t.date :part_a_first_interview_date
      t.string :interviewer_comment_first
      t.string :interviewer_comment_second
      t.string :interviewer_comment_others
      t.date :part_b_first_interview_date
      t.string :interviewer_comments
      t.string :part_c_name
      t.string :part_c_signature
      t.date :part_c_date
      t.integer :company_id
      t.integer :user_id
      t.integer :task_id
      t.string :part_c_name_1
      t.string :part_c_signatur_1
      t.date :part_c_date_1
      t.string :part_c_name_2
      t.string :part_c_signatur_2
      t.date :part_c_date_2

      t.timestamps
    end
  end
end
