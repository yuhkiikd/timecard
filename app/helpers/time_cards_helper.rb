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
    @affiliation_base_data = TimeCard.where(affiliation_id: @affiliation.id).group_date_asc_day

    @chart_days = @affiliation_base_data.minimum(:worked_in_at).values.map{ |item| item.strftime('%Y/%m/%d')}
    if Rails.env.production?#AWS用の時間データ抽出（AWS上だと時間の持ち方が違うため）
      @times = @affiliation_base_data.sum(:overtime).values.map{ |item| Time.at(item - 32400).strftime('%X:%M').to_i}
    elsif Rails.env.development?#開発環境の時間データ抽出
      @times = @affiliation_base_data.sum(:overtime).values.map{ |item| Time.at(item).strftime('%X:%M').to_i}
    end
  end

  private

  #退勤時間保存
  def worked_out_save
    @time_card.worked_out_at = @now_at
    if @time_card.breaked_time.present?
      @time_card.worked_time = (@time_card.worked_out_at - @time_card.worked_in_at - @time_card.breaked_time).to_i
      @time_card.save
    else
      @time_card.worked_time = (@time_card.worked_out_at - @time_card.worked_in_at).to_i
      @time_card.save
    end
    if @time_card.breaked_time? && 28800 < @time_card.worked_time
      @time_card.worked_time -= @time_card.breaked_time
      @time_card.overtime = (@time_card.worked_time - 28800).to_i
      @time_card.save
    elsif 28800 < @time_card.worked_time
      @time_card.overtime = (@time_card.worked_time - 28800).to_i
      @time_card.save
    end
    redirect_to time_cards_path, notice: '勤怠データを記録しました'
  end

  #休憩開始時間保存
  def breaked_in_save
    @time_card.breaked_in_at = @now_at
    @time_card.save
    redirect_to time_cards_path, notice: '勤怠データを記録しました'
  end

  #休憩終了時間保存
  def breaked_out_save
    @time_card.breaked_out_at = @now_at
    @time_card.breaked_time = (@time_card.breaked_out_at - @time_card.breaked_in_at).to_i
    @time_card.save
    redirect_to time_cards_path, notice: '勤怠データを記録しました'
  end

  #勤怠時間編集（休憩あり）
  def time_edit_save
    @time_card.breaked_time = (@time_card.breaked_out_at - @time_card.breaked_in_at).to_i
    @time_card.worked_time = (@time_card.worked_out_at - @time_card.worked_in_at - @time_card.breaked_time ).to_i
    @time_card.save
    if 28800 < @time_card.worked_time
      @time_card.overtime = (@time_card.worked_time - 28800).to_i
    else
      @time_card.overtime = 0
    end
    @time_card.update(time_card_edit_params)
    redirect_to all_index_time_cards_path, notice: '勤怠データを記録しました'
  end

  def time_edit_no_breaked_save
    @time_card.worked_time = (@time_card.worked_out_at - @time_card.worked_in_at).to_i
    @time_card.save
    if 28800 < @time_card.worked_time
      @time_card.overtime = (@time_card.worked_time - 28800).to_i
    else
      @time_card.overtime = 0
    end
    @time_card.update(time_no_breaked_edit_params)
    @time_card.update(breaked_in_at: nil,breaked_out_at: nil, breaked_time: 0)
    redirect_to all_index_time_cards_path, notice: '勤怠データを記録しました'
  end
end