require "rails_helper"

describe "Api::V1::Sessions" do
  describe "#create" do
    context "when the params are valid" do
      it "returns a 200 status code" do
        user_login_with_valid_params

        expect(response).to have_http_status(200)
      end

      it "returns JWT token in authorization header" do
        user_login_with_valid_params

        expect(response.headers["Authorization"]).to be_present
      end

      it "returns a valid JWT token" do
        user_login_with_valid_params

        decoded_token = decoded_jwt_token_from_response(response)

        expect(decoded_token.first['sub']).to be_present
      end
    end

    context "when the params are invalid" do
      it "returns unauthorized status" do
        post "/api/v1/login"

        expect(response).to have_http_status(401)
      end
    end
  end

  describe "#destroy" do
    it "returns 204, no content" do
      delete "/api/v1/logout"

      expect(response).to have_http_status(204)
    end
  end

  def user_login_with_valid_params
    user = create(:user)
    params = { user: { email: user.email, password: user.password } }

    post "/api/v1/login", params: params
  end

  def decoded_jwt_token_from_response(response)
    token_from_request = response.headers['Authorization'].split(' ').last
    jwt_secret_key = ENV['DEVISE_JWT_SECRET_KEY']

    JWT.decode(token_from_request, jwt_secret_key, true)
  end
end
