class InstrumentalLike < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :instrumental, touch: true

  validates :instrumental, presence: true, uniqueness: { scope: :user_id }
  validates :user, presence: true
end
