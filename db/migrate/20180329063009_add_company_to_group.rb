class AddCompanyToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :company_id, :integer
  end
end
