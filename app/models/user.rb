class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable
  has_one  :profile, dependent: :destroy
  has_many :team_users
  has_many :teams, through: :team_users

  def user_name
    profile.nil? ? email : profile.name
  end
end
