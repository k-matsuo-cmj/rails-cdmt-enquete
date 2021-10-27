class EnquetesForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :sender_id, :string
  attribute :title, :string
  attribute :deadline, :date
  attribute :users, :string_array

  validates :title, presence: true
  validates :deadline, presence: true
  validates :users, presence: true #TODO

  def save
    enquete = Enquete.new(sender_id: sender_id, title: title, deadline: deadline)
    users.reject(&:blank?).each do |user_id|
      enquete.replies.build(user_id: user_id)
    end
    enquete.save
  end
end