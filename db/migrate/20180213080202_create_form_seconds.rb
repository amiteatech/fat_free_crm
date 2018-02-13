class CreateFormSeconds < ActiveRecord::Migration[5.0]
  def change
    create_table :form_seconds do |t|
      t.string :name
      t.string :module_title
      t.string :course
      t.date :course_date
      t.integer :module_toucht_by_id
      t.integer :company_id
      t.integer :user_id
      t.integer :task_id

      t.timestamps
    end
  end
end
