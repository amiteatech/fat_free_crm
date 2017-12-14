class CreateTaskComments < ActiveRecord::Migration[5.0]
  def change
    create_table :task_comments do |t|
      t.integer :task_id
      t.integer :user_id
      t.string :user_name
      t.string :comments

      t.timestamps
    end
  end
end
