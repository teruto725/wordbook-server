module V1
  class WordSerializer < ActiveModel::Serializer
    attributes :id,:english, :japanese, :difficulty
  end
end