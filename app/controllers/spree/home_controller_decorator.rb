module Spree
  HomeController.class_eval do
    after_filter :set_fastly_sidechannels

    private

    def set_fastly_sidechannels
      if spree_current_user.nil?
        set_cache_control_headers
        surrogate_keys = keys_for_collections(:products, :taxonomies, :taxons)
        surrogate_keys += @products.map(&:record_key) if @products
        set_surrogate_key_header surrogate_keys
      end
    end
  end
end