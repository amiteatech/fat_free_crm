class CreateFileUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :file_uploads do |t|
      t.integer :task_id
      t.string :file

      t.timestamps
    end
  end
end
