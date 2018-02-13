class CreateFormSecondDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :form_second_details do |t|
      t.string :week
      t.string :topic
      t.string :textbook
      t.string :teaching_activity
      t.string :teacher_remark
      t.string :supervisor_remark
      t.integer :form_second_id
      t.integer :position

      t.timestamps
    end
  end
end
