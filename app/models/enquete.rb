class Enquete < ApplicationRecord
  belongs_to :sender, class_name: "User"
  has_many :replies, dependent: :destroy
  default_scope { order(created_at: :desc) }

  validates :title, presence: true
  validates :deadline, presence: true
  validate  :deadline_gte_today

  private
    def deadline_gte_today
      unless deadline.blank?
        if deadline < Date.today
          errors.add(:deadline, "は本日以降の日付を入力してください")
        end
      end
    end
end
