require 'spec_helper'

describe Spree::User do
  describe "user instance" do
    let(:user) { create(:user) }
    let(:unsaved_user) { build(:user) }

    describe 'when saved' do
      it 'invokes #spree_purge callbacks' do
        expect(user).to receive(:spree_purge)
        user.save
      end
    end

    describe 'when created' do
      it 'invokes #spree_purge callbacks' do
        expect(unsaved_user).to receive(:spree_purge)
        unsaved_user.save
      end
    end

    describe 'when destroyed' do
      it 'invokes #spree_purge callbacks' do
        expect(user).to receive(:spree_purge)
        user.destroy
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
          unsaved_user.save
        end
      end

      describe 'when saved' do
        it 'sends a purge request' do
          user.save
        end
      end
    end
  end
end

