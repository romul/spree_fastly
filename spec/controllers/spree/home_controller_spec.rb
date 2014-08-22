require 'spec_helper'

describe Spree::HomeController do
  it "responds with success" do
    spree_get :index
    response.status.should == 200
  end
end
