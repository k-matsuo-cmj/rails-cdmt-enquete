class EnquetesForm
  include ActiveModel::Model
  
  attr_accessor :sender_id, :title, :deadline, :users

  validates :title, presence: true
  validates :deadline, presence: true
  validates :users, presence: true #TODO

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
end