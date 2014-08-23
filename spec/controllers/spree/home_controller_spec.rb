require 'spec_helper'

describe Spree::HomeController do
  it "responds with success" do
    spree_get :index
    response.should be_cacheable
  end
end
