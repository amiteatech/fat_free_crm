# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Eatech CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class UserMailer < ActionMailer::Base
  def password_reset_instructions(user)
    @edit_password_url = edit_password_url(user.perishable_token)

    mail subject: "Educert Process Control System: " + I18n.t(:password_reset_instruction),
         to: user.email,
         from: 'admin@educertpro.com',
         date: Time.now
  end

  def assigned_entity_notification(entity, assigner)
    @entity_url = url_for(entity)
    @entity_name = entity.name
    @entity_type = entity.class.name
    @assigner_name = assigner.name
    mail subject: "Educert Process Control System: You have been assigned #{@entity_name} #{@entity_type}",
         to: entity.assignee.email,
         from: 'admin@educertpro.com'
  end

  private

  def from_address
    # from = (Setting.smtp || {})[:from]
    # !from.blank? ? from : "Eatech CRM <noreply@fatfreecrm.com>"
    from = "admin@educertpro.com"
  end
end
