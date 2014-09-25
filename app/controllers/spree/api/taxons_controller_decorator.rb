module Spree
  module Api
    TaxonsController.class_eval do
      after_filter :set_fastly_sidechannels, :only => [:products]

      private

      def respond_with(*resources, &block)
        if ['index', 'show'].include?(action_name)
          set_cache_control_headers
          surrogate_keys = keys_for_collections(:taxonomies, :taxons)
          surrogate_keys += @taxons.map(&:record_key) if @taxons
          surrogate_keys << @taxon.record_key if @taxon
          set_surrogate_key_header surrogate_keys
        end
        super
      end

      def set_fastly_sidechannels
        set_cache_control_headers
        surrogate_keys = keys_for_collections(:products)
        surrogate_keys += @products.map(&:record_key)
        set_surrogate_key_header surrogate_keys
      end
    end
  end
end