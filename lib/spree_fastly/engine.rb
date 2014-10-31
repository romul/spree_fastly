module SpreeFastly
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_fastly'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    # Initializer to combine this engines static assets with the static assets of the hosting site.
    initializer "static assets" do |app|
      app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
    end

    def self.activate
      Spree::StoreController.send :include, SpreeFastly::ControllerHelpers
      Spree::Api::BaseController.send :include, SpreeFastly::ControllerHelpers

      Spree::Base.send :include, SpreeFastly::PurgeSupport
      Spree::User.send :include, SpreeFastly::PurgeSupport
      
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
