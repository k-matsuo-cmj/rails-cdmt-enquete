module DeviseHelper
  # for flash message
  def bootstrap_alert(key)
    case key
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    end
  end

  # admin user signed in?
  def admin_signed_in?
    user_signed_in? && current_user.admin
  end
end