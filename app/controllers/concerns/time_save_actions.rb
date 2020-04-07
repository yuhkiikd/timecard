module TimeSaveActions
  extend ActiveSupport::Concern

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

  #勤怠時間編集（休憩なし）
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