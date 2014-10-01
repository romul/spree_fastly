module Spree
  ProductsController.class_eval do
    after_filter :set_fastly_sidechannels, :only => [:index, :show], :if => :can_be_cached

    private

    def set_fastly_sidechannels
      set_cache_control_headers
      surrogate_keys = keys_for_collections(:products, :taxonomies, :taxons)
      surrogate_keys << @taxon.record_key if @taxon

      if action_name == 'index'
        surrogate_keys += @products.map(&:record_key)
      elsif action_name == 'show'
        surrogate_keys << @product.record_key
      end

      set_surrogate_key_header surrogate_keys
    end

  end
end