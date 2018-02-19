class AddCompanyIdInUserAndTask < ActiveRecord::Migration[5.0]
  def change
  	add_column :tasks, :company_id, :integer
  end
end
