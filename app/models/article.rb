class Article < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :tags
  has_many :comments
  validates :title, presence: true, length: { minimum: 5 }
  validates :text, presence: true, length: { minimum: 50 }
end
