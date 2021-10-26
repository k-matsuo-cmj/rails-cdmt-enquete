class Enquete < ApplicationRecord
  belongs_to :sender, class_name: "User"
  has_many :replies, dependent: :destroy
  default_scope { order(created_at: :desc) }

  validates :title, presence: true
  validates :deadline, presence: true
end
