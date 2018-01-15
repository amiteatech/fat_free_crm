class AddContentTypeToFileUpload < ActiveRecord::Migration[5.0]
  def change
    add_column :file_uploads, :file_name, :string
    add_column :file_uploads, :content_type, :string
    add_column :file_uploads, :file_contents, :binary
  end
end
