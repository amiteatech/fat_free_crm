class CreateSchoolFolders < ActiveRecord::Migration[5.0]
  def change
    create_table :school_folders do |t|
      t.string :name
      t.integer :company_id
      t.string :path

      t.timestamps
    end
  end
end
