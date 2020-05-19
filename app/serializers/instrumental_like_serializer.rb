class InstrumentalLikeSerializer < ActiveModel::Serializer
  attributes :id, :instrumental, :user, :created_at
end
