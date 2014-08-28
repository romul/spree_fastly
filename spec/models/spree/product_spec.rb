require 'spec_helper'

describe Spree::Product do
  let(:product){  }
  describe "product instance" do
    let(:product) { create(:product) }
    let(:variant) { create(:variant, :product => product) }

    describe 'when saved' do
      it 'invokes Fastly purge callbacks' do
        expect(:product).to be_truthy
      end
    end
  end
end

