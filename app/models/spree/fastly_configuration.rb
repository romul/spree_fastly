class Spree::FastlyConfiguration < Spree::Preferences::Configuration
  attr_accessor :perform_purges

  # see https://github.com/fastly/fastly-rails#configuration
  preference :api_key, :string
  preference :user, :string
  preference :password, :strong
  preference :max_age, :integer, :default => 2592000
  preference :service_id, :string

  def perform_purges?
    perform_purges && FastlyRails.configuration.authenticatable?
  end

  def disable_purges!
    self.perform_purges = false
  end

  def enable_purges!
    self.perform_purges = true
  end

  def purged_collections
    Set.new [
      :products,
      :taxonomies,
      :taxons,
      :users
    ]
  end

  def purge_all!
    purged_collections.each do |collection|
      clazz = "Spree::#{collection.to_s.classify}".safe_constantize
      clazz.purge_all if clazz
    end
  end

end
