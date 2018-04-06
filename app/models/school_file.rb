class SchoolFile < ApplicationRecord
	serialize :groups, Array

	belongs_to :school_folder

	has_attached_file :avatar
  do_not_validate_attachment_file_type :avatar
end
