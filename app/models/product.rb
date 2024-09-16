class Product < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :name, presence: true
  validates :url, presence: true, uniqueness: true

  def self.cached_products
    Rails.cache.fetch("products", expires_in: 10.minutes) { all.to_a }
  end
end
