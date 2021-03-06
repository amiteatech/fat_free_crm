# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Eatech CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/opportunities/show" do
  include OpportunitiesHelper

  before do
    login_and_assign
    @opportunity = FactoryGirl.create(:opportunity, id: 42,
                                                    contacts: [FactoryGirl.create(:contact)])
    assign(:opportunity, @opportunity)
    assign(:users, [current_user])
    assign(:comment, Comment.new)
    assign(:timeline, [FactoryGirl.create(:comment, commentable: @opportunity)])
  end

  it "should render opportunity landing page" do
    render
    expect(view).to render_template(partial: "comments/_new")
    expect(view).to render_template(partial: "shared/_timeline")
    expect(view).to render_template(partial: "shared/_tasks")
    expect(view).to render_template(partial: "contacts/_contact")

    expect(rendered).to have_tag("div[id=edit_opportunity]")
  end
end
