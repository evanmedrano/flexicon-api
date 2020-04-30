class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist,
         :omniauth_providers => [:facebook, :google_oauth2]

end
