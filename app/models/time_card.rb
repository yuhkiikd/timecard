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
      self.where(user: user).order(:day).all
    end
  end
end