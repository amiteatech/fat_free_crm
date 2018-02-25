class AddFieldsIntoTasks < ActiveRecord::Migration[5.0]
  def change
  	add_column :tasks, :task_year_id, :integer
  	add_column :tasks, :task_form_tag_id, :integer
  	add_column :tasks, :school_item_no_id, :integer
  	add_column :tasks, :school_item_no, :string
  	add_column :tasks, :task_form_category, :string
  end
end
