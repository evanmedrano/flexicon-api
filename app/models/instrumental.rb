class Instrumental < ApplicationRecord
  has_many :instrumental_likes
  has_many :user_likes, through: :instrumental_likes, source: :user

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :track, presence: true
end
