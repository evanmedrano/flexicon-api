module OauthSupport
  def stub_oauth(options = {})
    OmniAuth.config.test_mode = true
    mock_provider = options[:provider] || :facebook

    OmniAuth.config.mock_auth[mock_provider] =
      OmniAuth::AuthHash.new({
        :provider => "facebook",
        :uid => "12345",
        :info => {
          :email => "facebook_email@example.com",
          :image => "oauth_image.png",
          :name => "Oauth User"
        }
      }.merge(options))
  end
end

RSpec.configure do |config|
  config.include OauthSupport, type: :feature
  config.include OauthSupport, type: :request
end
