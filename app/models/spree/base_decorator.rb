module Spree
  Base.class_eval do
    after_create :purge_all
    after_save :purge
    after_destroy :purge, :purge_all

    def purge_all
      super if perform_purges?
    end

    def purge
      super if perform_purges?
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
