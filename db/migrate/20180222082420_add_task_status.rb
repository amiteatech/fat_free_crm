class AddTaskStatus < ActiveRecord::Migration[5.0]
  def change
  	add_column :tasks, :task_status, :string
  end
end
