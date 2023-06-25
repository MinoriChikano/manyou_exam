class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :password, length: { minimum: 4 }
end
