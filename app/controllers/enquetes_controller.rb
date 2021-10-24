class EnquetesController < ApplicationController
  before_action :authenticate_user!

  def index
    @enquetes = Enquete.where(team: managed_teams)
  end

  def show
    @enquete = Enquete.find(params[:id])
  end

  def new
    @enquete = Enquete.new
    @teams = managed_teams
    @users = User.joins(:team_users).where('team_users.team_id IN (?)', managed_teams.ids)
  end

  def create
    @enquete = Enquete.new(enquete_params)
    params[:enquete][:users].reject(&:blank?).each { |user_id| @enquete.replies.build(user_id: user_id) }
    if @enquete.save
      flash[:notice] = "アンケートを送信しました。"
      redirect_to enquetes_url
    else
      flash.now[:error] = "入力に誤りがあります。"
      @teams = managed_teams
      render :new
    end
  end

  def edit
    @enquete = Enquete.find(params[:id])
  end

  private
    def enquete_params
      params.require(:enquete).permit(:team_id, :title, :deadline, :users)
    end

    def managed_teams
      Team.where(manager: current_user)
    end
end
