class Word < ApplicationRecord
  validates :japanese, presence: true
  validates :english, presence: true
  belongs_to :user
end
