class Api::V1::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    begin
      sign_in user_from_auth_hash
      render json: {"status":"200", "message":"Facebook authentication successful."}
    rescue
      render json: {"status":"400", "message":"Error authenticating the user."}
    end
  end

  def google_oauth2
    begin
      sign_in user_from_auth_hash
      render json: {"status":"200", "message":"Google authentication successful."}
    rescue
      render json: {"status":"400", "message":"Error authenticating the user."}
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
