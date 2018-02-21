class AddPartCDateToFormFirst < ActiveRecord::Migration[5.0]
  def change
    add_column :form_firsts, :part_c_name_1, :string
    add_column :form_firsts, :part_c_signatur_1, :string
    add_column :form_firsts, :part_c_date_1, :date
    add_column :form_firsts, :part_c_name_2, :string
    add_column :form_firsts, :part_c_signatur_2, :string
    add_column :form_firsts, :part_c_date_2, :date
  end
end
