module Spree
  module Api
    TaxonomiesController.class_eval do

      private

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

      def index_surrogate_keys
        custom_keys = @taxonomies.map(&:record_key)
        @taxonomies.each do |taxonomy|
          custom_keys += surrogate_keys_for_taxons_by(taxonomy)
        end
        custom_keys
      end

      def show_surrogate_keys
        [@taxonomy.record_key] + surrogate_keys_for_taxons_by(@taxonomy)
      end

      def surrogate_keys_for_taxons_by(taxonomy)
        if params[:set] == 'nested'
          taxonomy.taxons.map(&:record_key)
        else
          [taxonomy.root.record_key] + taxonomy.root.children.map(&:record_key)
        end
      end
    end
  end
end