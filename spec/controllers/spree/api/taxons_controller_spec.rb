require 'spec_helper'

describe Spree::Api::TaxonsController do
  render_views

  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, :name => "Ruby", :taxonomy => taxonomy) }
  let(:taxon2) { create(:taxon, :name => "Rails", :taxonomy => taxonomy) }
  let!(:product) { create(:product) }
  let!(:product2) { create(:product) }

  before do
    stub_authentication!
    taxon.children << taxon2
    taxonomy.root.children << taxon
    taxon.products = [product, product2]
  end

  context "should set correct headers when" do
    it "gets all taxons" do
      api_get :index

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(taxon.record_key)
      expect(response).to have_surrogate_keys(taxon2.record_key)
    end

    it "gets all taxons for a taxonomy" do
      api_get :index, :taxonomy_id => taxonomy.id

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      # only first level taxons
      expect(response).to have_surrogate_keys(taxon.record_key)
    end

    it "paginates through taxons" do
      new_taxon = create(:taxon, :name => "Go", :taxonomy => taxonomy)
      taxonomy.root.children << new_taxon
      expect(taxonomy.root.children.count).to eql(2)
      api_get :index, :taxonomy_id => taxonomy.id, :page => 2, :per_page => 1

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(new_taxon.record_key)
      expect(response).not_to have_surrogate_keys(taxon.record_key)
      expect(response).to have_surrogate_keys("page=2")
      expect(response).to have_surrogate_keys("per_page=1")
    end

    it "gets a single taxon" do
      api_get :show, :id => taxon.id, :taxonomy_id => taxonomy.id

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(taxon.record_key)
    end

    it "gets products of taxon" do
      api_get :products, :id => taxon.id

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('products')
      expect(response).to have_surrogate_keys(product.record_key)
      expect(response).to have_surrogate_keys(product2.record_key)
    end

  end
end