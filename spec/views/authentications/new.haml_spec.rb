# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Eatech CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/authentications/new" do
  include AuthenticationsHelper

  before do
    activate_authlogic
    assign(:authentication, @authentication = Authentication.new)
  end

  it "renders the login form without signup link" do
    expect(view).to receive(:can_signup?).and_return(false)
    render
    expect(rendered).to have_tag("form[action='#{authentication_path}'][class=new_authentication]")
    expect(rendered).not_to have_tag("a[href='#{signup_path}']")
  end

  it "renders the login form with signup link" do
    expect(view).to receive(:can_signup?).and_return(true)
    render
    expect(rendered).to have_tag("form[action='#{authentication_path}'][class=new_authentication]")
    expect(rendered).to have_tag("a[href='#{signup_path}']")
  end
end
