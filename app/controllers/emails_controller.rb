# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Eatech CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class EmailsController < ApplicationController
  skip_before_filter 'checksuper_admin'
  before_action :require_user

  # DELETE /emails/1
  # DELETE /emails/1.json
  # DELETE /emails/1.xml                                                   AJAX
  #----------------------------------------------------------------------------
  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    respond_with(@email)
  end
end
