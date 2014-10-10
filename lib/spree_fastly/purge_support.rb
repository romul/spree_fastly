module SpreeFastly
  module PurgeSupport
    extend ActiveSupport::Concern
    included do
      after_save :spree_purge
      after_destroy :spree_purge

      def spree_purge
        if perform_purges?
          purge
          purge_all
        end
      end

      def perform_purges?
        Spree::Fastly::Config.perform_purges? &&
        Spree::Fastly::Config.purged_collections.include?(collection_name_sym)
      end

      def collection_name_sym
        self.class.name.demodulize.tableize.to_sym
      end
    end
  end
end