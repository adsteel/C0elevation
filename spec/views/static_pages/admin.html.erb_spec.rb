require 'spec_helper'

describe "statis_pages/admin" do
  before(:each) do
    admin = create(:admin)
    sign_in admin
  end
end
