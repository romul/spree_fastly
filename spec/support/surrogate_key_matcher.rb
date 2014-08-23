RSpec::Matchers.define :have_surrogate_keys do |keys|
  match do |response|
    response.headers['Surrogate-Key'] &&
    response.headers['Surrogate-Key'].match(/#{keys}/)
  end

  # Optional failure messages
  failure_message_for_should do |actual|
    "expected response headers to be indexed under '#{keys}'"
  end

  failure_message_for_should_not do |actual|
    "expected response headers not to be indexed under '#{keys}'"
  end

  # Optional method description
  description do
    "checks response's Surrogate-Control headers"
  end
end

