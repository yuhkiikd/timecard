class TimeCardsController < ApplicationController
  PER = 10
  before_action :set_time_card, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?
  before_action :ensure_admin, only: [:all_index, :edit]
  before_action :set_month, only: [:index]
  before_action :set_date, only: [:new]
  before_action :can_not_edit, only: [:edit]
  before_action :time_card_today, only: [:new, :create]
  before_action :now_at, only: [:update]

  def index
    @time_cards = monthly_time_cards(current_user, @year, @month)
  end

  def all_index
    @time_cards = TimeCard.page(params[:page]).per(PER).order(worked_in_at: "DESC")
  end

  def new
  end

  def create
    if params[:worked_in]
      @time_card.affiliation_id = current_user.affiliation_id
      @time_card.worked_in_at = DateTime.current.change(sec: 00)
      if @time_card.year != @time_card.worked_in_at.year||\
         @time_card.month != @time_card.worked_in_at.month||\
         @time_card.day != @time_card.worked_in_at.day
         redirect_to all_index_time_cards_path, notice: '不正な日時です'
      else
        @time_card.save
        redirect_to time_cards_path, notice: '勤怠データを記録しました'
      end
    end
  end

  def edit
  end

  def update
    if params[:worked_out]
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
    elsif params[:breaked_in]
      @time_card.breaked_in_at = @now_at
      @time_card.save
      redirect_to time_cards_path, notice: '勤怠データを記録しました'
    elsif params[:breaked_out]
      @time_card.breaked_out_at = @now_at
      @time_card.breaked_time = (@time_card.breaked_out_at - @time_card.breaked_in_at).to_i
      @time_card.save
      redirect_to time_cards_path, notice: '勤怠データを記録しました'
    elsif params[:time_edit]
      @time_card.breaked_time = (@time_card.breaked_out_at.to_i - @time_card.breaked_in_at.to_i).to_i
      @time_card.worked_time = (@time_card.worked_out_at.to_i - @time_card.worked_in_at.to_i - @time_card.breaked_time ).to_i
      @time_card.save
      if 28800 < @time_card.worked_time
        @time_card.overtime = (@time_card.worked_time - 28800).to_i
      else
        @time_card.overtime = 0
      end

      if @time_card.update(time_card_edit_params)
        redirect_to all_index_time_cards_path, notice: '勤怠データを記録しました'
      else
        render :edit
      end
    else
      redirect_to all_index_time_cards_path, notice: '勤怠データを記録出来ませんでした'
    end
  end

  def show
  end

  def destroy
    if @time_card.destroy
      redirect_to all_index_time_cards_url, notice: '勤怠データを削除しました！'
    end
  end

  private

  def monthly_time_cards(user, year, month)
    number_of_days_in_month = Date.new(year, month, 1).next_month.prev_day.day
    results = Array.new(number_of_days_in_month) # 月の日数分nilで埋めた配列を用意
    time_cards = TimeCard.where(year: @year, month: @month).monthly(user, year, month)
    time_cards.each do |card|
      results[card.day - 1] = card
    end
    results
  end

  def set_time_card
    @time_card = TimeCard.find(params[:id])
  end

  def time_card_params
    params.require(:time_card).permit(:year, :month, :day, :worked_in_at, :worked_out_at, :breaked_in_at, :breaked_out_at, :user_id, :affiliation_id)
  end

  def time_card_edit_params
    params.require(:time_card).permit(:year, :month, :day, :worked_in_at, :worked_out_at, :breaked_in_at, :breaked_out_at, :user_id, :affiliation_id, :worked_time, :breaked_time, :overtime)
  end

  def can_not_edit
    if @time_card.worked_out_at == nil
      redirect_to all_index_time_cards_path, alert: '編集は退勤時間を記録してから可能です。'
    end
  end

  def time_card_today
    @time_card = TimeCard.today(current_user)
  end

  def now_at
    @now_at = Time.current.change(sec: 00)
  end
end