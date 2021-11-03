class EnquetesController < ApplicationController
  require 'csv'
  before_action :authenticate_user!
  before_action :manager_user
  before_action :sender_user, only: [:show, :edit, :update, :delete]

  def show
    @enquete = Enquete.find(params[:id])
    respond_to do |format|
      format.html
      format.csv {send_csv(@enquete)}
    end
  end

  def new
    @form = EnquetesForm.new
    # @teams = managed_teams
    @users = managed_team_users
  end

  def create
    @form = EnquetesForm.new(enquete_form_params)
    @form.sender_id = current_user.id
    if @form.save
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
    @users = managed_team_users
  end

  def update
    @enquete = Enquete.find(params[:id])
    if @enquete.update(enquete_update_params)
      flash[:notice] = "アンケートを更新しました。"
      redirect_to enquete_url(params[:id])
    else
      flash.now[:error] = "入力に誤りがあります。"
      @users = managed_team_users
      render :edit
    end
  end

  def destroy
    @enquete = Enquete.find(params[:id])
    @enquete.destroy
    flash[:notice] = "アンケートを削除しました。"
    redirect_to root_url
  end

  private
    def enquete_form_params
      params.require(:enquete).permit(:title, :deadline, users: [])
    end

    def enquete_update_params
      params.require(:enquete).permit(:title, :deadline)
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

    # CSV出力処理
    def send_csv(enquete)
      bom = "\uFEFF"
      data = CSV.generate(bom, force_quotes: true) do |csv|
        csv << CSV_COLUMNS
        enquete.replies.each do |reply|
          csv << reply.to_csv
        end
      end
      send_data(data, filename: "enqreply_#{Time.current.strftime("%Y%m%d%H%M%S")}.csv")
    end

    # CSVヘッダカラム
    CSV_COLUMNS = %w(
      氏名 回答日時 社員番号 グレード ステータス
      PJ_テクニカル・スキル PJ_人間関係 PJ_アピール・問題点
      希望職種 1年後_グレード 1年後_人材イメージ 1年後_行動・目標
      3年後_グレード 3年後_人材イメージ 3年後_行動・目標
      5年後_グレード 5年後_人材イメージ 5年後_行動・目標
      現_CD目標① 現_進捗率① 現_進捗状況① 現_弊害・問題点①
      現_CD目標② 現_進捗率② 現_進捗状況② 現_弊害・問題点②
      次_CD目標① 次_分配率① 次_CD目標② 次_分配率②
      受講日・セミナー名 受講時間合計
      業務知識 顧客評価・CSサービス 会社貢献度 仕事の量・質 積極性 規律性 責任性
      上長マネージャに対する要望 営業部に対する要望 管理部に対する要望 会社に対する要望
    )
end
