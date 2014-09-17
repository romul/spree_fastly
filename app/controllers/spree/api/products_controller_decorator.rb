module Spree
  module Api
    ProductsController.class_eval do

      def respond_with(*resources, &block)
        if ['index', 'show'].include?(action_name)
          set_cache_control_headers
          surrogate_keys = keys_for_collections(:products)
          surrogate_keys += @products.map(&:record_key) if @products
          surrogate_keys << @product.record_key if @product
          surrogate_keys << request.query_string if request.query_string.present?
          set_surrogate_key_header surrogate_keys
        end
        super
      end

    end
  end
end