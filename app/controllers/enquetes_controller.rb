class EnquetesController < ApplicationController
  before_action :authenticate_user!
  before_action :manager_user
  before_action :editable_user, only: [:show, :edit, :update, :delete]

  def show
    @enquete = Enquete.find(params[:id])
  end

  def new
    @enquete = Enquete.new
    # @teams = managed_teams
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
      # @teams = managed_teams
      @users = managed_team_users
      render :new
    end
  end

  def edit
    @enquete = Enquete.find(params[:id])
  end

  def update
    #TODO
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

    # マネージャのみ参照可能
    def manager_user
      unless managed_teams.present?
        flash[:alert] = "アクセスできません。"
        redirect_to root_url
      end
    end

    # アンケート送信者のみ編集可能
    def editable_user
      enquete = Enquete.find_by(id: params[:id])
      unless enquete && enquete.sender == current_user
        flash[:alert] = "アクセスできません。"
        redirect_to root_url
      end
    end
end
