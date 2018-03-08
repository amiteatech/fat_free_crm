class SupplementaryTaskFile < ApplicationRecord
  belongs_to :task
  has_attached_file :file
  do_not_validate_attachment_file_type :file
 # validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
