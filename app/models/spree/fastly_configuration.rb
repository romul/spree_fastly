class Spree::FastlyConfiguration < Spree::Preferences::Configuration

  # see https://github.com/fastly/fastly-rails#configuration
  preference :api_key, :string
  preference :user, :string
  preference :password, :strong
  preference :max_age, :integer, :default => 2592000
  preference :service_id, :string
end
