class User < ApplicationRecord
  has_secure_password
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  before_save { self.email = email.downcase }
end
