module TimeCardsHelper
  def date_in_japanese(date = Date.today, format = :full)
    case format
    when :full
      "#{date.year}年#{date.month}月#{date.day}日 #{day_of_the_week_in_japanese(date)}"
    when :month_day
      "#{date.month}月#{date.day}日"
    end
  end

  # 曜日の日本語表現を取得する
  def day_of_the_week_in_japanese(date, format = :full)
    result =
      case date.wday
      when 0
        '日曜日'
      when 1
        '月曜日'
      when 2
        '火曜日'
      when 3
        '水曜日'
      when 4
        '木曜日'
      when 5
        '金曜日'
      when 6
        '土曜日'
      end

    format == :short ? result[0] : result
  end

  def each_date_in_month(year, month)
    date = Date.new(year, month, 1)
    while date.month == month do
      yield date, date.day - 1
      date = date.next_day
    end
  end

  def year_select
    TimeCard.group(:year).select("year")
  end

  # 勤務状況を取得する
  def working_status(time_card)
    case time_card.working_status
    when :not_arrived
      '未出社'
    when :working
      '勤務中'
    when :breaking
      '休憩中'
    when :left
      '退社済'
    end
  end

  def time_str(time)
    time ? time.strftime('%H:%M') : ''
  end

  def time_count(time)
    time ? Time.at(time).strftime('%H:%M') : ''
  end

  def int_to_hour(f = time.to_i.to_f)
    f ? f / 3600 : ''
  end

  def int_to_minutes(f = time.to_i.to_f)
    f ? (f % 3600 / 60).floor.ceil : '' 
  end

  def sec_to_minutes(f = time.to_i.to_f)
    f ? f / 60.floor.ceil : '' 
  end

  def int_to_time(time)
    time.to_i ? Time.at(time).strftime('%M') : ''
  end

  #従業員の詳細用データ
  def set_user_chart_data
    @timecard_base_data = TimeCard.where(year: @year, month: @month, user_id: @user.id)

    @chart_days = @timecard_base_data.asc.pluck(:worked_in_at).map{ |item| item.strftime('%Y/%m/%d')}
    if Rails.env.production?#AWS用の時間データ抽出（AWS上だと時間の持ち方が違うため）
      @chart_times = @timecard_base_data.asc.pluck(:overtime).map{ |item| Time.at(item - 32400).strftime('%X:%M').to_i}
    elsif Rails.env.development?#開発環境の時間データ抽出
      @chart_times = @timecard_base_data.asc.pluck(:overtime).map{ |item| Time.at(item).strftime('%X:%M').to_i}
    end
    @worked_time = @timecard_base_data.sum(:worked_time)
    @overtime = @timecard_base_data.sum(:overtime)
  end

  #所属のグラフ用データ
  def set_affiliation_chart_data
    @affiliation_base_data = TimeCard.where(year: @year, month: @month, affiliation_id: @affiliation.id).group_date_asc_day

    @chart_days = @affiliation_base_data.minimum(:worked_in_at).values.map{ |item| item.strftime('%Y/%m/%d')}
    if Rails.env.production?#AWS用の時間データ抽出（AWS上だと時間の持ち方が違うため）
      @times = @affiliation_base_data.sum(:overtime).values.map{ |item| Time.at(item - 32400).strftime('%X:%M').to_i}
    elsif Rails.env.development?#開発環境の時間データ抽出
      @times = @affiliation_base_data.sum(:overtime).values.map{ |item| Time.at(item).strftime('%X:%M').to_i}
    end
  end
end