# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Eatech CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module UsersHelper
  def language_for(user)
    if user.preference[:locale]
      _locale, language = languages.detect { |locale, _language| locale == user.preference[:locale] }
    end
    language || "English"
  end

  def sort_by_language
    languages.sort.map do |locale, language|
      %[{ name: "#{language}", on_select: function() { #{redraw(:locale, [locale, language], url_for(action: :redraw, id: current_user))} } }]
    end
  end

  def all_users
    User.by_name.where(:company_id => current_user.company_id)
  end

  def user_select(asset, users, myself)
    user_options = user_options_for_select(users, myself)
    select(asset, :assigned_to, user_options,
           { include_blank: t(:unassigned) },
           style:         "width:160px",
           class: 'select2')
  end

  def multi_user_select(asset, users, task_id)
   # raise users.inspect
    assignedUsers = UserTask.where(task_id: @task.id).pluck(:user_id)
    select_tag 'users[]', options_for_select( users.map {|s| [s.name, s.id]}, assignedUsers), class: 'select2_tag', :multiple => true, :size => 10
  end

  def user_options_for_select(users, myself)
    (users - [myself]).map { |u| [u.full_name, u.id] }.prepend([t(:myself), myself.id])
  end
end
