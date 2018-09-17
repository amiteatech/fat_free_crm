class CreateRestrictedGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :restricted_groups do |t|
      t.integer :task_id
      t.integer :group_id

      t.timestamps
    end
  end
end
