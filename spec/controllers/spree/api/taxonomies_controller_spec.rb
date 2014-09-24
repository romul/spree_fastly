require 'spec_helper'

describe Spree::Api::TaxonomiesController do
  render_views

  let(:taxonomy) { create(:taxonomy) }
  let(:taxonomy2) { create(:taxonomy, :name => "Test2") }
  let(:taxon) { create(:taxon, :name => "Ruby", :taxonomy => taxonomy) }
  let(:taxon2) { create(:taxon, :name => "Rails", :taxonomy => taxonomy) }

  before do
    stub_authentication!
    taxon.children << taxon2
    taxonomy.root.children << taxon
    taxonomy2.root.children = [] 
  end

  context "should set correct headers when" do
    it "gets all taxonomies" do
      api_get :index

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(taxonomy.record_key)
      expect(response).to have_surrogate_keys(taxonomy.root.record_key)
      expect(response).to have_surrogate_keys(taxon.record_key)
      expect(response).to have_surrogate_keys(taxonomy2.record_key)
      expect(response).to have_surrogate_keys(taxonomy2.root.record_key)
    end

    it 'paginates through taxonomies' do
      api_get :index, :per_page => 1, :page => 2

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(taxonomy2.record_key)
      expect(response).to have_surrogate_keys(taxonomy2.root.record_key)
      expect(response).to have_surrogate_keys("page=2")
      expect(response).to have_surrogate_keys("per_page=1")
    end

    it "gets a single taxonomy" do
      api_get :show, :id => taxonomy.id

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(taxonomy.record_key)
      expect(response).to have_surrogate_keys(taxonomy.root.record_key)
      expect(response).to have_surrogate_keys(taxon.record_key)
    end

    it "gets a single taxonomy with set=nested" do
      api_get :show, :id => taxonomy.id, :set => 'nested'

      expect(response).to be_cacheable
      expect(response).to have_surrogate_keys('taxonomies')
      expect(response).to have_surrogate_keys('taxons')
      expect(response).to have_surrogate_keys(taxonomy.record_key)
      expect(response).to have_surrogate_keys(taxonomy.root.record_key)
      expect(response).to have_surrogate_keys(taxon.record_key)
      expect(response).to have_surrogate_keys(taxon2.record_key)
    end
  end

end