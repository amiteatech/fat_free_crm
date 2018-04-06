class CreateSchoolFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :school_files do |t|
      t.string :name
      t.string :avatar
      t.integer :school_folder_id
      t.string :groups

      t.timestamps
    end
  end
end
