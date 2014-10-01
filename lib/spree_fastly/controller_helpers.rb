module SpreeFastly
  module ControllerHelpers
    # Receives 1..n symbols converting them to Spree classes
    # and asking each of the respective ::table_key
    def keys_for_collections *collections
      raise "Provide at least one symbol representing a Rails model" unless collections.present?

      collections.map do |collection|
        clazz = "Spree::#{collection.to_s.classify}".safe_constantize
        clazz.table_key if clazz
      end.compact
    end

    def can_be_cached
      spree_current_user.nil? && current_order.nil? && flash.notice.blank?
    end
  end
end