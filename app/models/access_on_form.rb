class AccessOnForm < ApplicationRecord
  serialize :users_id
   before_save :meta_tidy 
   def meta_tidy
    self.users_id = nil if self.users_id.class == String
    self.users_id = self.users_id.delete_if{|x| x == "" }  unless self.users_id.nil?
   end 

  def self.get_user_groups(company_id, access_on_form)
  	selected_groups = []
  	Group.all.where(company_id: company_id).each do |group|
  		present = true
  		group.users.each do |user|
  			if access_on_form.users_id.present?
	  			unless access_on_form.users_id.include?(user.id)
	  				present = false
	  			end
	  		end
  		end
  		if present
  			selected_groups << group.id
  		end
  	end
  	return selected_groups
  end
end
