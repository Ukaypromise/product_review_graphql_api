class Product < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true, uniqueness: true
end
