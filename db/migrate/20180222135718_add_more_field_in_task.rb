class AddMoreFieldInTask < ActiveRecord::Migration[5.0]
  def change
  	add_column :tasks, :years, :string
  	add_column :tasks, :is_cancelled, :boolean, :default => false
  end
end
