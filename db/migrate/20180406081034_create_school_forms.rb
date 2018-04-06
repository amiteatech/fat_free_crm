class CreateSchoolForms < ActiveRecord::Migration[5.0]
  def change
    create_table :school_forms do |t|
      t.string :name
      t.integer :company_id
      t.string :users_id
      t.timestamps
    end
    SchoolForm.create(:name => "Workflow")
    SchoolForm.create(:name => "Monitoring")
    SchoolForm.create(:name => "Approval")
  end
end
