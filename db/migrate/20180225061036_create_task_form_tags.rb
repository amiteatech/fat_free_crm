class CreateTaskFormTags < ActiveRecord::Migration[5.0]
  def change
    create_table :task_form_tags do |t|
      t.string :name
      t.boolean :status, :default => true
      t.integer :company_id

      t.timestamps
    end
    TaskFormTag.create(:name => "Workflow")
    TaskFormTag.create(:name => "Monitoring")
    TaskFormTag.create(:name => "Approval")
  end
end
