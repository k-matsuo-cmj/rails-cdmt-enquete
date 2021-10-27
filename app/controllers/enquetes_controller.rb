class EnquetesController < ApplicationController
  before_action :authenticate_user!
  before_action :manager_user
  before_action :sender_user, only: [:show, :edit, :update, :delete]

  def show
    @enquete = Enquete.find(params[:id])
  end

  def new
    @form = EnquetesForm.new
    # @teams = managed_teams
    @users = managed_team_users
  end

  def create
    @form = EnquetesForm.new(enquete_params)
    @form.sender_id = current_user.id
    if @form.save
      flash[:notice] = "アンケートを送信しました。"
      redirect_to root_url
    else
      flash.now[:error] = "入力に誤りがあります。"
      p @form.errors
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
      params.require(:enquetes_form).permit(:title, :deadline, users: [])
    end

    def managed_teams
      Team.where(manager: current_user)
    end

    def managed_team_users
      User.joins(:team_users).where('team_users.team_id IN (?)', managed_teams.ids)
    end

    # マネージャのみ使用可能
    def manager_user
      unless managed_teams.present?
        flash[:alert] = "アクセスできません。"
        redirect_to root_url
      end
    end

    # 作成後のアンケートは、送信者のみ参照・編集可能
    def sender_user
      enquete = Enquete.find_by(id: params[:id])
      unless enquete && enquete.sender == current_user
        flash[:alert] = "アクセスできません。"
        redirect_to root_url
      end
    end
end
