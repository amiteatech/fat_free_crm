FactoryGirl.define do
  factory :user_task do
    task_id 1
    user_id 1
    comments "MyString"
    files "MyString"
    position 1
    task_status "MyString"
    approved_time "2017-12-05 14:20:41"
    rejected_time "2017-12-05 14:20:41"
    approved false
    rejected false
  end
end
