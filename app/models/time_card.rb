class TimeCard < ApplicationRecord
  belongs_to :user

  class << self
    # 今日のタイムカードを取得する
    def today(user)
      date = Date.current
      condition = { user: user, year: date.year, month: date.month, day: date.day }
      self.find_by(condition) || self.new(condition)
    end

    # 指定年月のタイムカードを取得する
    def monthly(user, year, month)
      self.where(user: user, year: year, month: month).order(:day).all
    end
  end

  def monthly_time_cards(user, year, month)
    number_of_days_in_month = Date.new(year, month, 1).next_month.prev_day.day
    results = Array.new(number_of_days_in_month) # 月の日数分nilで埋めた配列を用意
    results.overtime = 0
    time_cards = TimeCard.monthly(user, year, month)
    time_cards.each do |card|
      results[card.day - 1] = card
    end
    results
  end
end