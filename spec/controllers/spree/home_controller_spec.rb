require 'spec_helper'

describe Spree::HomeController do
  it "responds with success" do
    spree_get :index

    response.should be_cacheable
    response.should have_surrogate_keys('products')
    response.should have_surrogate_keys('taxonomies')
    response.should have_surrogate_keys('taxons')
  end
end
