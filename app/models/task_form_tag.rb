class TaskFormTag < ApplicationRecord
	has_many :tasks
	has_many :task_form_tag_values
	has_many :option_values
end
