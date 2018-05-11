# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Eatech CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
#
# Configure ActionMailer unless running tests
#   ActionMailer is setup in test mode later on
#
unless Rails.env.test?

  smtp_settings = Setting.smtp || {}

  Setting.smtp

  if smtp_settings["address"].present?
    Rails.application.config.action_mailer.smtp_settings = smtp_settings.symbolize_keys
  end

  if (host = Setting.host).present?
    (Rails.application.routes.default_url_options ||= {})[:host] = host.gsub('http://', '')
  end

end

# if Rails.env.development? or Rails.env.test?
#   class OverrideMailRecipient
#     def self.delivering_email(mail)
#       mail.to = ''
#     end
#   end
#   ActionMailer::Base.register_interceptor(OverrideMailRecipient)
# end