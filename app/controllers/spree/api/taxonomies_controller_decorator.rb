module Spree
  module Api
    TaxonomiesController.class_eval do

      def respond_with(*resources, &block)
        if ['index', 'show'].include?(action_name)
          set_cache_control_headers
          surrogate_keys = keys_for_collections(:taxonomies, :taxons)

          if action_name == 'index'
            surrogate_keys += index_surrogate_keys
          elsif action_name == 'show'
            surrogate_keys += show_surrogate_keys
          end
          surrogate_keys << request.query_string if request.query_string.present?
          set_surrogate_key_header surrogate_keys
        end
        super
      end

      private

      def index_surrogate_keys
        custom_keys = @taxonomies.map(&:record_key)
        @taxonomies.each do |taxonomy|
          custom_keys << taxonomy.root.record_key
          custom_keys += taxonomy.root.children.map(&:record_key)
        end
        custom_keys
      end

      def show_surrogate_keys
        custom_keys = [@taxonomy.record_key, @taxonomy.root.record_key]
        custom_keys += @taxonomy.root.children.map(&:record_key)
      end
    end
  end
end