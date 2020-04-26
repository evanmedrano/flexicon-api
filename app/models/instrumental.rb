class Instrumental < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :track, presence: true
end
