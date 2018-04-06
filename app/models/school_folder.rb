class SchoolFolder < ApplicationRecord
	has_many :school_files, dependent: :destroy
end
