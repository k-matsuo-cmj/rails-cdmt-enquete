module HomeHelper
  # ログインユーザーがマネージャかどうかを返す
  def manager?
    Team.find_by(manager: current_user).present?
  end
end
