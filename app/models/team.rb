class Team < ApplicationRecord
  belongs_to :manager, class_name: "User"
  has_many   :team_users
  has_many   :users, through: :team_users
  has_many   :enquetes
end
