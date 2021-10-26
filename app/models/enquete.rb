class Enquete < ApplicationRecord
  belongs_to :sender, class_name: "User"
  has_many :replies, dependent: :destroy

  validates :title, presence: true
  validates :deadline, presence: true
end
