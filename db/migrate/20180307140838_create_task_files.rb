class CreateTaskFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :task_files do |t|
      t.string :name
      t.integer :task_id

      t.timestamps
    end
    add_attachment :task_files, :file
  end
end
