class TaskFormTagValue < ApplicationRecord
	belongs_to :task_form_tag
	has_one :option_value
end
