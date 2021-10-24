class Enquete < ApplicationRecord
  belongs_to :team
  has_many :replies, dependent: :destroy

  validates :team_id, presence: true
  validates :title, presence: true
  validates :deadline, presence: true
end
