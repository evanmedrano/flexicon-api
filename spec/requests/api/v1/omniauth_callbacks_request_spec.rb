require 'rails_helper'

describe "Api::V1::OmniauthCallbacks" do
  describe "#facebook" do
    context "when the user is new" do
      it "signs up the user" do
        stub_oauth(info: { email: "new_user@gmail.com" })

        get "/api/v1/auth/facebook/callback"

        expect(User.count).to eq 1
        expect(User.last.email).to eq "new_user@gmail.com"
        expect(response.body).to include "Facebook authentication successful."
      end
    end

    context "when the user already exists" do
      it "logs in the user" do
        user = create(:user, email: "new_user@gmail.com")
        stub_oauth(info: { email: user.email })

        get "/api/v1/auth/facebook/callback"

        expect(User.count).not_to eq 2
        expect(response.body).to include "Facebook authentication successful."
      end
    end

    context "when the user's auth provider is set as google" do
      it "logs in the user" do
        user = create(:user, :with_google_auth)
        stub_oauth(info: { email: user.email })

        get "/api/v1/auth/facebook/callback"

        expect(User.count).not_to eq 2
        expect(response.body).to include "Facebook authentication successful."
      end
    end

    context "when the request is unsuccessful" do
      it "returns an error message" do
        get "/api/v1/auth/facebook/callback.json"

        expect(response.body).to include "Error authenticating the user."
      end
    end
  end

  describe "#google_oauth2" do
    context "when the user is new" do
      it "signs up the user" do
        stub_oauth(provider: :google_oauth2)

        get "/api/v1/auth/google_oauth2/callback"

        expect(User.count).to eq 1
        expect(User.last.auth_provider).to eq "google_oauth2"
        expect(response.body).to include "Google authentication successful."
      end
    end

    context "when the user already exists" do
      it "logs in the user" do
        user = create(:user, email: "new_user@gmail.com")
        stub_oauth(provider: :google_oauth2, info: { email: user.email })

        get "/api/v1/auth/google_oauth2/callback"

        expect(User.count).not_to eq 2
        expect(response.body).to include "Google authentication successful."
      end
    end

    context "when the user's auth provider is set as facebook" do
      it "logs in the user" do
        user = create(:user, :with_facebook_auth)
        stub_oauth(provider: :google_oauth2, info: { email: user.email })

        get "/api/v1/auth/google_oauth2/callback"

        expect(User.count).not_to eq 2
        expect(response.body).to include "Google authentication successful."
      end
    end

    context "when the request is unsuccessful" do
      it "returns an error message" do
        get "/api/v1/auth/google_oauth2/callback.json"

        expect(response.body).to include "Error authenticating the user."
      end
    end
  end
end
