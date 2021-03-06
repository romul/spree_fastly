require 'spec_helper'

describe FastlyRails::Configuration do
  describe 'when configuring via block' do
    it 'raises' do
      expect{
        FastlyRails.configure do |c|
          c.api_key = 'FASTLY_API_KEY'
        end
      }.to raise_error
    end
  end

  describe 'when setting config values directly' do
    it 'raises' do
      expect{
        subject.api_key = 'FASTLY_API_KEY'
      }.to raise_error
    end
  end

  describe 'when accessing config values' do
    it 'returns Spree::Fastly::Config preference values' do
      new_value = "NEW-VALUE-#{rand(9)}"
      Spree::Fastly::Config[:api_key] = new_value
      expect(subject.api_key).to eq(new_value)
    end
  end
end

