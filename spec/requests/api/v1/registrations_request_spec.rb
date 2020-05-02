require 'rails_helper'

describe "Api::V1::Registrations" do
  describe "#create" do
    context "when the user is unauthenticated" do
      it "returns a 200 status code" do
        new_user_signup_with_valid_params

        expect(response).to have_http_status(200)
      end

      it "returns a new user" do
        new_user_signup_with_valid_params

        expect(User.count).to eq 1
      end
    end

    context "when the user already exists" do
      it "returns a bad request status code" do
        existing_user_signup

        expect(response).to have_http_status(400)
      end

      it "returns validation errors" do
        existing_user_signup

        expect(parsed_response['errors']['title']).to eq('Bad Request')
      end
    end
  end

  def new_user_signup_with_valid_params
    params = { user: { email: "user@example.com", password: "foobar" } }

    post "/api/v1/signup", params: params
  end

  def existing_user_signup
    user = create(:user)
    params = { user: { email: user.email, password: "foobar" } }

    post "/api/v1/signup", params: params
  end

  def parsed_response
    JSON.parse(response.body)
  end
end
