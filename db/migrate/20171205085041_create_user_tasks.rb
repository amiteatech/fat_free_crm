class CreateUserTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_tasks do |t|
      t.integer :task_id
      t.integer :user_id
      t.string :comments
      t.string :files
      t.integer :position
      t.string :task_status
      t.datetime :approved_time
      t.datetime :rejected_time
      t.boolean :approved
      t.boolean :rejected

      t.timestamps
    end
  end
end
