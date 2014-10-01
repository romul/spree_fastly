module Spree
  TaxonsController.class_eval do
    after_filter :set_fastly_sidechannels, :only => [:show], :if => :can_be_cached

    private

    def set_fastly_sidechannels
      set_cache_control_headers
      surrogate_keys = keys_for_collections(:products, :taxonomies, :taxons)
      surrogate_keys << @taxon.record_key
      surrogate_keys += @products.map(&:record_key)
      set_surrogate_key_header surrogate_keys
    end
  end
end
