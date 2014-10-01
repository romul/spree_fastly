require 'spec_helper'

describe Spree::TaxonsController do
  let!(:taxon) { create(:taxon, :permalink => "test") }
  let!(:product) { create(:product, :available_on => 1.year.ago, :taxon_ids => [taxon.id]) }
  let!(:user) { mock_model(Spree.user_class, :last_incomplete_spree_order => nil, :spree_api_key => 'fake') }

  describe 'on #show' do
    it "sets correct headers for guest" do
      spree_get :show, :id => taxon.permalink

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('products')
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(taxon.record_key)
      expect(response).to have_surrogate_keys(product.record_key)
    end

    it "doesn't set cache headers for user" do
      controller.stub :spree_current_user => user
      spree_get :show, :id => taxon.permalink

      expect(response).not_to be_cacheable
      expect(response).to have_no_surrogate_keys
    end

    it "doesn't set cache headers if there is a guest order" do
      controller.stub :current_order => create(:order)
      spree_get :show, :id => taxon.permalink

      expect(response).not_to be_cacheable
      expect(response).to have_no_surrogate_keys
    end

  end
end
