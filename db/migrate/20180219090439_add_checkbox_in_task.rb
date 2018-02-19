class AddCheckboxInTask < ActiveRecord::Migration[5.0]
  def change
  	add_column :tasks, :form_first, :boolean
  	add_column :tasks, :form_second, :boolean
  	add_column :tasks, :form_third, :boolean
  	add_column :tasks, :form_first_id, :integer
  	add_column :tasks, :form_second_id, :integer
  	add_column :tasks, :form_third_id, :integer

  	add_column :tasks, :form_number, :integer
  end
end


