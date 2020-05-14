class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist,
         :omniauth_providers => [:facebook, :google_oauth2]

  has_many :instrumental_likes
  has_many :liked_instrumentals, through: :instrumental_likes, source: :instrumental

  validates :username, uniqueness: { case_sensitive: false }, allow_nil: true
end
