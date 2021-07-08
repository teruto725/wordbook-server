class Wordbook < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :words,dependent: :destroy
end
