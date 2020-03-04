class TimeCard < ApplicationRecord
  belongs_to :user
  validates :year, presence: true
  validates :month, presence: true
  validates :day, presence: true
  validates :worked_in_at, presence: true
  validate :is_time_correct?

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

  def working_status
    case [!!worked_in_at, !!worked_out_at, !!breaked_in_at, !!breaked_out_at]
    when [false, false, false, false]
      :not_arrived # 未出社
    when [true, false, false, false]
      :working # 勤務中
    when [true, false, true, true]
      :working # 勤務中
    when [true, false, true, false]
      :breaking # 休憩中
    when [true, true, true, true]
      :left # 退社済
    when [true, true, false, false]
      :left # 退社済
    when [true, true, true, false]
      :left # 退社済
    end
  end

  private

  def is_time_correct?
    return if worked_in_at.nil? || worked_out_at.nil?
    if worked_in_at > worked_out_at
      errors[:base] << '退社時間は、出社時間より後の時間である必要があります ※保存は完了していません'
    end
  end
end