class Comment < ApplicationRecord
  belongs_to :project

  validates :text, presence: true, length: { maximum: 255 }
  validates :username, presence: true, length: { maximum: 100 }
end
