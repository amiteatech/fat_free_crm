class CreateSchoolItemNumbers < ActiveRecord::Migration[5.0]
  def change
    create_table :school_item_numbers do |t|
      t.string :name
      t.integer :company_id
      t.boolean :status, :default => true

      t.timestamps
    end
   # SchoolItemNumber.create(:name => "2017")
   # SchoolItemNumber.create(:name => "2017-2018")
  end
end
