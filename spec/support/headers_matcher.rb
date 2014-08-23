RSpec::Matchers.define :be_cacheable do
  match do |response|
    response.headers['Cache-Control'] &&
    response.headers['Cache-Control'].match(/public/)
  end

  # Optional failure messages
  failure_message_for_should do |actual|
    "expected response headers to include correct Cache-Control"
  end

  failure_message_for_should_not do |actual|
    "expected response headers to exclude cacheable Cache-Control directives"
  end

  # Optional method description
  description do
    "checks response's Cache-Control headers"
  end
end
