class User < ApplicationRecord
  has_many :tasks
  has_secure_password
  validates :password, length: { minimum: 4 }
end
