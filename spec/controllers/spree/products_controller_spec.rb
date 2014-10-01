require 'spec_helper'

describe Spree::ProductsController do
  let!(:taxon) { create(:taxon, :permalink => "test") }
  let!(:product1) { create(:product, :available_on => 1.year.ago, :taxon_ids => [taxon.id]) }
  let!(:product2) { create(:product, :available_on => 1.year.ago, :taxon_ids => [taxon.id]) }
  let!(:user) { mock_model(Spree.user_class, :last_incomplete_spree_order => nil, :spree_api_key => 'fake') }


  describe 'on #index' do
    it "sets correct headers for guest" do
      spree_get :index

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('products')
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(product1.record_key)
      expect(response).to have_surrogate_keys(product2.record_key)
    end

    it "sets correct headers for guest when taxon is set" do
      spree_get :index, :taxon => taxon.id

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('products')
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(product1.record_key)
      expect(response).to have_surrogate_keys(product2.record_key)
      expect(response).to have_surrogate_keys(taxon.record_key)
    end

    it "doesn't set cache headers for user" do
      controller.stub :spree_current_user => user
      spree_get :index

      expect(response).not_to be_cacheable
      expect(response).to have_no_surrogate_keys
    end

  end

  describe 'on #show' do
    it "sets correct headers for guest" do
      spree_get :show, :id => product1.slug

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('products')
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(product1.record_key)
    end

    it "sets correct headers for guest when taxon is set" do
      spree_get :show, :id => product1.slug, :taxon_id => taxon.id

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('products')
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(product1.record_key)
      expect(response).to have_surrogate_keys(taxon.record_key)
    end

    it "doesn't set cache headers for user" do
      controller.stub :spree_current_user => user
      spree_get :show, :id => product1.slug

      expect(response).not_to be_cacheable
      expect(response).to have_no_surrogate_keys
    end

  end
end
