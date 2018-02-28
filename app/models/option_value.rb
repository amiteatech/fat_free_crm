class OptionValue < ApplicationRecord
   belongs_to :task_form_tag_value
   belongs_to :task
end
