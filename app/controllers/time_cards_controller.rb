class TimeCardsController < ApplicationController
  before_action :set_time_card, only: [:show, :edit, :update, :destroy]

  def index
    today = Date.current
    @year = today.year
    @month = today.month
    @time_cards = TimeCard.monthly(current_user, @year, @month)
  end

  def new
    @time_card = TimeCard.today(current_user)
  end

  def create
    @time_card = TimeCard.today(current_user)
    
    if params[:worked_in]
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
    elsif params[:worked_out]
      @time_card.worked_out_at = Time.now
      @time_card.worked_time = (@time_card.worked_out_at - @time_card.worked_in_at).to_i
      if @time_card.breaked_time? && 28800 < @time_card.worked_time.to_i
        @time_card.worked_time -= @time_card.breaked_time
        @time_card.overtime = (@time_card.worked_time - 28800).to_i
      elsif 28800 < @time_card.worked_time
        @time_card.overtime = (@time_card.worked_time - 28800).to_i
      else
        @time_card.overtime = 0
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

  def detroy
  end

  private

  def monthly_time_cards(user, year, month)
  end

  def set_time_card
    @time_card = TimeCard.find(params[:id])
  end

  def time_card_params
    params.require(:time_card).permit(:year, :month, :day, :worked_in_at, :worked_out_at, :breaked_in_at, :breaked_out_at, :user_id)
  end
end