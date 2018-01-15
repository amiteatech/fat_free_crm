class FileUpload < ApplicationRecord
	belongs_to :task

	# def initialize(params = {})
	#   file = params.delete(:file_upload)
	#   super
	#   if file
	#     self.file = sanitize_filename(file.original_filename)
	#     self.content_type = file.content_type
	#     self.file_contents = file.read
	#   end
	# end
	# private
 #  def sanitize_filename(filename)
 #    # Get only the filename, not the whole path (for IE)
 #    # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
 #    return File.basename(filename)
 #  end

  def uploaded_file=(incoming_file)
    self.file = incoming_file.original_filename
    self.content_type = incoming_file.content_type
    self.file_contents = incoming_file.read
  end

  def filename=(new_filename)
    write_attribute("file", sanitize_filename(new_filename))
  end

  private
  def sanitize_filename(filename)
    #get only the filename, not the whole path (from IE)
    just_filename = File.basename(file)
    #replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/, '_')
  end

end
	