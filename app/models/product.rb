class Product < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :name, presence: true
  validates :url, presence: true, uniqueness: true
end
