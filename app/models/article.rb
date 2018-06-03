class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates :text, presence: true, length: { minimum: 50 }

  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :tags
  has_many :comments, dependent: :destroy

  # mount_uploader :image, ImageUploader
end
