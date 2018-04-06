class AccessOnForm < ApplicationRecord
  serialize :users_id
   before_save :meta_tidy 
   def meta_tidy
    self.users_id = nil if self.users_id.class == String
    self.users_id = self.users_id.delete_if{|x| x == "" }  unless self.users_id.nil?
   end 
end
