require 'spec_helper'

describe Spree::Api::ProductsController do
  render_views

  let!(:product) { create(:product) }
  let!(:product2) { create(:product) }
  let!(:inactive_product) { create(:product, available_on: Time.now.tomorrow, name: "inactive") }

  before do
    stub_authentication!
    products = [product, product2, inactive_product]
  end

  context "should set correct headers when" do

    it "gets all products" do
      api_get :index
      
      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('products')
      expect(response).to have_surrogate_keys(product.record_key)
      expect(response).to have_surrogate_keys(product2.record_key)
      expect(response).not_to have_surrogate_keys(inactive_product.record_key)
    end

    it "gets a list of products by id" do
      api_get :index, :ids => [product.id]

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('products')
      expect(response).to have_surrogate_keys(product.record_key)
      expect(response).not_to have_surrogate_keys(product2.record_key)
      expect(response).not_to have_surrogate_keys(inactive_product.record_key)
    end


    it "paginates through products" do
      api_get :index, :page => 2, :per_page => 1

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('products')
      expect(response).not_to have_surrogate_keys(product.record_key)
      expect(response).to have_surrogate_keys(product2.record_key)
    end



    it "gets a single product" do
      api_get :show, :id => product.to_param

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('products')
      expect(response).to have_surrogate_keys(product.record_key)
    end


  end

end