module Spree
  StoreController.class_eval do

    # Receives 1..n symbols converting them to Spree classes
    # and asking each of the respective ::table_key
    def depends_on_collections *collections
      raise "Provide at least one symbol representing a Rails model" unless collections.present?

      clazzes = collections.map do |collection|
        "Spree::#{collection.to_s.singularize.capitalize}".safe_constantize
      end.compact

      set_surrogate_key_header clazzes.map(&:table_key).join(' ')
    end
  end
end
