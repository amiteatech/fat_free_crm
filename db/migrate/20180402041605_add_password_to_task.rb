class AddPasswordToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :password, :string
    add_column :tasks, :password_protected, :boolean
  end
end
