module V1
  class WordSerializer < ActiveModel::Serializer
    attributes :id,:english, :japanese, :difficulty, :count
  end
end