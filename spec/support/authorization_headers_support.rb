require 'devise/jwt/test_helpers'

module AuthorizationHeadersSupport
  def authorize(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end
end

RSpec.configure do |config|
  config.include AuthorizationHeadersSupport, type: :request
end
