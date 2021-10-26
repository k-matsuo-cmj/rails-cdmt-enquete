class EnquetesController < ApplicationController
  before_action :authenticate_user!

  def show
    @enquete = Enquete.find(params[:id])
  end

  def new
    @enquete = Enquete.new
    @teams = managed_teams
    @users = managed_team_users
  end

  def create
    @enquete = Enquete.new(enquete_params)
    @enquete.sender = current_user
    # TODO form class
    params[:enquete][:users].reject(&:blank?).each { |user_id| @enquete.replies.build(user_id: user_id) }
    if @enquete.save
      flash[:notice] = "アンケートを送信しました。"
      redirect_to root_url
    else
      flash.now[:error] = "入力に誤りがあります。"
      @teams = managed_teams
      @users = managed_team_users
      render :new
    end
  end

  def edit
    @enquete = Enquete.find(params[:id])
  end

  def destroy
    @enquete = Enquete.find(params[:id])
    @enquete.destroy
    flash[:notice] = "アンケートを削除しました。"
    redirect_to root_url
  end

  private
    def enquete_params
      params.require(:enquete).permit(:title, :deadline)
    end

    def managed_teams
      Team.where(manager: current_user)
    end

    def managed_team_users
      User.joins(:team_users).where('team_users.team_id IN (?)', managed_teams.ids)
    end
end
