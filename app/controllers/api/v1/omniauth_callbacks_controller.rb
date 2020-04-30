module Api::V1
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      begin
        sign_in user_from_auth_hash
        render json: {"status":"200", "message":"Facebook authentication successful."},
          status: :ok
      rescue
        render json: {"status":"400", "message":"Error authenticating the user."},
          status: :bad_request
      end
    end

    def google_oauth2
      begin
        sign_in user_from_auth_hash
        render json: {"status":"200", "message":"Google authentication successful."},
          status: :ok
      rescue
        render json: {"status":"400", "message":"Error authenticating the user."},
          status: :bad_request
      end
    end

    private

    def user_from_auth_hash
      AuthHashService.new(auth_hash).find_or_create_user_from_auth_hash
    end

    def auth_hash
      request.env["omniauth.auth"]
    end
  end
end
