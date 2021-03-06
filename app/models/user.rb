class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable, :trackable
  devise :database_authenticatable, :registerable, :validatable

  after_create :update_access_token!

  validates :email, presence: true

  has_many :wordbooks, dependent: :destroy

  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end

end