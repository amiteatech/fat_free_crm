class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :admin_id
      t.string :address1
      t.string :address2
      t.string :city
      t.string :country
      t.string :prime_contact
      t.string :prime_phone_number
      t.boolean :status

      t.timestamps
    end
  end
end
