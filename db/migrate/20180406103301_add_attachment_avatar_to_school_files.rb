class AddAttachmentAvatarToSchoolFiles < ActiveRecord::Migration
  def self.up
    change_table :school_files do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :school_files, :avatar
  end
end
