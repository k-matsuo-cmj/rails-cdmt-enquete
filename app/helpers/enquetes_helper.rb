module EnquetesHelper
  # 期限まであと何日かを返す
  def remain(date)
    (date - Date.current).to_i
  end

  # 「あと何日」の表示を行う
  def show_remain(date)
    r = remain(date)
    if r < 0
      "期限切れ"
    elsif r == 0
      "今日まで"
    else
      "あと#{r}日"
    end
  end

  # 「あと何日」を表示する際のclass
  def remain_class(date)
    r = remain(date)
    if r > 7
      "text-success"
    elsif r > 3
      "text-primary"
    elsif r > 0
      "text-danger"
    elsif r == 0
      "text-danger fw-bold"
    else
      "text-muted"
    end
  end

end
