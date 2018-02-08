class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :admin_id
      t.boolean :status
      t.string :email
      t.integer :phone
      t.string :address
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
