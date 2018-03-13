class CreateFormTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :form_types do |t|
      t.string :name
      t.boolean :status, :default => true
      t.integer :company_id

      t.timestamps
    end
  end
end
