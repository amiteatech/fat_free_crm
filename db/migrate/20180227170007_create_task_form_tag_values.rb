class CreateTaskFormTagValues < ActiveRecord::Migration[5.0]
  def change
    create_table :task_form_tag_values do |t|
      t.string :name
      t.integer :task_form_tag_id
      t.integer :company_id
      t.boolean :status
      t.timestamps
    end
  end
end
