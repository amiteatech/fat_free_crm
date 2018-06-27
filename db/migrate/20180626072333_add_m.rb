class AddM < ActiveRecord::Migration[5.0]
  def change
  	add_column :form_firsts, :part_b_name, :string
  	add_column :form_first_histories, :part_b_name, :string
  end
end
