# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Eatech CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class Group < ActiveRecord::Base
  # has_and_belongs_to_many :users
  has_many :permissions
  belongs_to :company
  has_many :user_groups
  has_many :users, through: :user_groups

  validates :name, presence: true, :uniqueness => {:scope => [:company_id]}

  ActiveSupport.run_load_hooks(:fat_free_crm_group, self)
end
