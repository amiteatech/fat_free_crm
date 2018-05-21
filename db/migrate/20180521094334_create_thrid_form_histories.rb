class CreateThridFormHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :thrid_form_histories do |t|
      t.integer :thrid_form_id
      t.integer :task_id
      t.integer :user_id
      t.string :module_title
      t.string :module_syllabus_no
      t.string :course
      t.string :module_toucht_by
      t.text :relevent_information
      t.text :student_performance
      t.text :evaluation
      t.text :module_development
      t.string :module_development_submitted_by
      t.date :module_development_submitted_date
      t.text :comments
      t.string :comments_name
      t.string :comments_signature
      t.string :comments_designation
      t.string :comments_date

      t.timestamps
    end
  end
end
