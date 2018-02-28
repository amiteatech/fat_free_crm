class CreateOptionValues < ActiveRecord::Migration[5.0]
  def change
    create_table :option_values do |t|
      t.integer :task_form_tag_value_id
      t.string :value
      t.integer :task_form_tag_id
      t.integer :task_id

      t.timestamps
    end
  end
end
