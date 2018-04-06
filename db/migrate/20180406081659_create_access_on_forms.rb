class CreateAccessOnForms < ActiveRecord::Migration[5.0]
  def change
    create_table :access_on_forms do |t|
      t.integer :school_form_id
      t.integer :company_id
      t.string :users_id

      t.timestamps
    end
  end
end
