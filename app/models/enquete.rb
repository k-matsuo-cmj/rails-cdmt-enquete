class Enquete < ApplicationRecord
  belongs_to :team
  has_many :replies, dependent: :destroy
end
