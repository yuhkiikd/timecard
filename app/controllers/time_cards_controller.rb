class TimeCardsController < ApplicationController
  before_action :set_time_card, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?
  before_action :ensure_admin, only: [:all_index, :edit]
  before_action :set_year_and_month, only: [:index]

  def index
    @time_cards = monthly_time_cards(current_user, @year, @month)
  end

  def all_index
    @time_cards = TimeCard.all.order(worked_in_at: "DESC")
  end

  def new
    @time_card = TimeCard.today(current_user)
  end

  def create
    @time_card = TimeCard.today(current_user)
    if params[:worked_in]
      @time_card.affiliation_id = current_user.affiliation_id
      @time_card.worked_in_at = DateTime.current
      @time_card.save
      redirect_to time_cards_path
    end
  end

  def edit
  end

  def update
    if @time_card.worked_time? && @time_card.breaked_time? && 28800 < (@time_card.worked_time - @time_card.breaked_time).to_i
      @time_card.overtime = (@time_card.worked_time - @time_card.breaked_time).to_i
      @time_card.save
      redirect_to time_cards_path
    elsif params[:worked_out]
      @time_card.worked_out_at = Time.now
      @time_card.worked_time = (@time_card.worked_out_at - @time_card.worked_in_at).to_i
      if @time_card.breaked_time? && 28800 < @time_card.worked_time.to_i
        @time_card.worked_time -= @time_card.breaked_time
        @time_card.overtime = (@time_card.worked_time - 28800).to_i
      elsif 28800 < @time_card.worked_time
        @time_card.overtime = (@time_card.worked_time - 28800).to_i
      end
      @time_card.save
      redirect_to time_cards_path
    elsif params[:breaked_in]
      @time_card.breaked_in_at = Time.now
      @time_card.save
      redirect_to time_cards_path
    elsif params[:breaked_out]
      @time_card.breaked_out_at = Time.now
      @time_card.breaked_time = (@time_card.breaked_out_at - @time_card.breaked_in_at).to_i
      @time_card.save
      redirect_to time_cards_path
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
end