class Reply < ApplicationRecord
  belongs_to :enquete
  belongs_to :user
  default_scope { order(created_at: :desc) }  
end
