module Spree
  HomeController.class_eval do
    after_filter :set_fastly_sidechannels, :except => [:csrf_meta_tags], :if => :can_be_cached

    def csrf_meta_tags
      render :layout => false
    end

    private

    def set_fastly_sidechannels
      set_cache_control_headers
      surrogate_keys = keys_for_collections(:products, :taxonomies, :taxons)
      surrogate_keys += @products.map(&:record_key) if @products
      set_surrogate_key_header surrogate_keys
    end
  end
end