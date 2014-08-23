module Spree
  HomeController.class_eval do
    before_filter :set_cache_control_headers
  end
end
