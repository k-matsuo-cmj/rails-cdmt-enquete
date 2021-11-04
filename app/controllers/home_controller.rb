class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @enquetes = Enquete.where(sender: current_user)
    @replies = Reply.where(user: current_user).order(created_at: :desc)
  end
  
end
