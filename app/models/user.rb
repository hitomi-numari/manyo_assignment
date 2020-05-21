class User < ApplicationRecord
  has_many :tasks
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :name, length: { in: 3..32 }
  validates :email, length: { in: 5..256 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_save { email.downcase! }
end
