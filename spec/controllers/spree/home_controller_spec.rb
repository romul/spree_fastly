require 'spec_helper'

describe Spree::HomeController do
  it "responds with success" do
    spree_get :index

    expect(response).to be_cacheable
    expect(response).to have_surrogate_keys('products')
    expect(response).to have_surrogate_keys('taxonomies')
    expect(response).to have_surrogate_keys('taxons')
  end
end
