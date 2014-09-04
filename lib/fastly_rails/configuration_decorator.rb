module FastlyRails
  Configuration.class_eval do
    [:api_key, :user, :password, :max_age, :service_id].each do |key|
      define_method("#{key}=") do |value|
        raise "Configuring fastly-rails directly is disabled. Use spree_fastly's administrator backend, instead."
      end

      define_method(key) do
        Spree::Fastly::Config[key]
      end
    end
  end
end
