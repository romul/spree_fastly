module Spree
  HomeController.class_eval do
    after_filter :set_fastly_sidechannels

    def set_fastly_sidechannels
      set_cache_control_headers
      depends_on_collections :products, :taxonomies, :taxons
    end
  end
end
