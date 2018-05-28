class Category < ApplicationRecord
  has_many :articles
  validates :name, presence: true, length: { minimum: 2 }
end
