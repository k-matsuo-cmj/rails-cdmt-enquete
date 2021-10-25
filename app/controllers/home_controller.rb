class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @enquetes = Enquete.where(team: managed_teams)
    @replies = Reply.where(user: current_user)
  end

  private
    def managed_teams
      Team.where(manager: current_user)
    end
end
