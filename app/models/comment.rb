class Comment < ApplicationRecord
  belongs_to :article
  validates :commenter, presence: true, length: { minimum: 1 }
  validates :message, presence: true, length: { minimum: 1 }
end
