class Spree::FastlyConfiguration < Spree::Preferences::Configuration
  attr_accessor :perform_purges

  # see https://github.com/fastly/fastly-rails#configuration
  preference :api_key, :string
  preference :user, :string
  preference :password, :strong
  preference :max_age, :integer, :default => 2592000
  preference :service_id, :string

  def perform_purges?
    perform_purges
  end

  def disable_purges!
    self.perform_purges = false
  end

  def enable_purges!
    self.perform_purges = true
  end

  def purged_collections
    Set.new [
      :products
    ]
  end

end
