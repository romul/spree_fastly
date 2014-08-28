require 'spec_helper'

describe Spree::Product do
  let(:product){  }
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
  end
end

