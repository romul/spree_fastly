module Spree
  module Fastly
    Config = Spree::FastlyConfiguration.new
    Config.enable_purges! unless Rails.env.test?
  end
end


