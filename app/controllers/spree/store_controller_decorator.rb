module Spree
  StoreController.class_eval do

    # Receives 1..n symbols converting them to Spree classes
    # and asking each of the respective ::table_key
    def keys_for_collections *collections
      raise "Provide at least one symbol representing a Rails model" unless collections.present?

      clazzes = collections.map do |collection|
        "Spree::#{collection.to_s.classify}".safe_constantize
      end.compact

      clazzes.map(&:table_key)
    end
  end
end
