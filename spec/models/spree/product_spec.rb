require 'spec_helper'

describe Spree::Product do
  describe "product instance" do
    let(:product) { create(:product) }
    let(:variant) { create(:variant, :product => product) }
    let(:unsaved_product) { build(:product) }

    describe 'when saved' do
      it 'invokes #purge callbacks' do
        expect(product).to receive(:purge)
        product.save
      end
    end

    describe 'when created' do
      it 'invokes #purge_all callbacks' do
        expect(unsaved_product).to receive(:purge_all)
        unsaved_product.save
      end
    end

    describe 'when destroyed' do
      it 'invokes #purge & #purge_all callbacks' do
        expect(product).to receive(:purge)
        expect(product).to receive(:purge_all)
        product.destroy
      end
    end

    describe 'when allowed to perform purges' do
      before do
        Spree::Fastly::Config.enable_purges!
        stub_request(:any, /api\.fastly\.com\/service/).
           to_return(:status => 200, :body => "{}", :headers => {})
      end
      after { Spree::Fastly::Config.disable_purges! }

      describe 'when created' do
        it 'sends a purge all request' do
          unsaved_product.save
        end
      end

      describe 'when saved' do
        it 'sends a purge request' do
          product.save
        end
      end
    end
  end
end

