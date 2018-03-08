class CreateSupplementaryTaskFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :supplementary_task_files do |t|
      t.string :name
      t.integer :task_id

      t.timestamps
    end
    add_attachment :supplementary_task_files, :file
  end
end
