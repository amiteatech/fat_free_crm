class AddRolesInUsers < ActiveRecord::Migration[5.0]
  def change
  	 add_column :users, :super_admin, :boolean, :default => false
  	 add_column :users, :school_admin, :boolean, :default => false
  	 add_column :users, :school_user, :boolean, :default => false
  end
end
