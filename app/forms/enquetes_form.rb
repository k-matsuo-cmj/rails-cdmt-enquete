class EnquetesForm
  include ActiveModel::Model
  
  attr_accessor :sender_id, :title, :deadline, :users

  validates :title, presence: true
  validates :deadline, presence: true
  validate  :deadline_gte_today
  validate  :users_presence

  def to_model
    enquete = Enquete.new(sender_id: sender_id, title: title, deadline: deadline)
    users.reject(&:blank?).each do |user_id|
      enquete.replies.build(user_id: user_id)
    end unless users.nil?
    return enquete
  end

  def save
    return false if invalid?
    to_model.save
  end

  private
    def deadline_gte_today
      unless deadline.nil?
        if Date.parse(deadline) < Date.today
          errors.add(:deadline, "は本日以降の日付を入力してください")
        end
      end
    end

    def users_presence
      if users.reject(&:blank?).empty?
        errors.add(:users, "を選択してください")
      end
    end
end