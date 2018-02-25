class CreateTaskYears < ActiveRecord::Migration[5.0]
  def change
    create_table :task_years do |t|
      t.string :name
      t.boolean :status, :default => true
      t.integer :company_id

      t.timestamps
    end
    TaskYear.create(:name => "2017")
    TaskYear.create(:name => "2017-2018")
    TaskYear.create(:name => "2018")
    TaskYear.create(:name => "2018-2019")
    TaskYear.create(:name => "2019")
  end
end
