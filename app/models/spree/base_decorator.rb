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
      Rails.env.staging? || Rails.env.production?
    end
  end
end
