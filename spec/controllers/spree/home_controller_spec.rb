require 'spec_helper'

describe Spree::HomeController do
  let!(:user) { mock_model(Spree.user_class, :last_incomplete_spree_order => nil, :spree_api_key => 'fake') }

  describe 'on #index' do
    it "sets correct headers for guest" do
      spree_get :index

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('products')
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
    end

    it "doesn't set cache headers for user" do
      controller.stub :spree_current_user => user
      spree_get :index

      expect(response).not_to be_cacheable
      expect(response).to have_no_surrogate_keys
    end

    it "doesn't set cache headers if there is a guest order" do
      controller.stub :current_order => create(:order)
      spree_get :index

      expect(response).not_to be_cacheable
      expect(response).to have_no_surrogate_keys
    end
  end
end