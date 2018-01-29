class AddUserCreatedDetailsToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :task_created_by, :string
    add_column :tasks, :task_created_id, :integer
  end
end
