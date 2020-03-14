class TimeCard < ApplicationRecord
  belongs_to :user
  belongs_to :affiliation
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 2020 }
  validates :month, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :day, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
  validate :is_time_correct?
  validate :valid_date
  validate :valid_in_out_date
  validates :worked_in_at, presence: true
  validates :worked_time, presence: true
  validates :breaked_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :overtime, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :affiliation_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1}
  validates :user_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1}

  scope :group_date_asc_day, -> { group(:year, :month, :day).order(day: "ASC") }
  scope :asc, -> { order(day: "ASC") }

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
    return if worked_in_at.nil? || worked_out_at.nil? || breaked_in_at.nil? || breaked_out_at.nil?
    if worked_in_at > worked_out_at || worked_in_at > breaked_in_at || worked_in_at > breaked_out_at ||\
       worked_out_at < breaked_in_at || worked_out_at < breaked_out_at || breaked_in_at > breaked_out_at
      errors[:base] << '出勤日時　＜　休憩開始日時　＜　休憩終了日時　＜　退勤日時で入力してください'
    end
  end

  def valid_date
    return if errors[:year].any? || errors[:month].any? || errors[:day].any?
    if !Date.valid_date?(year, month, day)
      errors[:alert] << '不正な日付です'
    end
  end

  def valid_in_out_date
    return if worked_in_at.nil? || worked_out_at.nil? || breaked_in_at.nil? || breaked_out_at.nil?
    return if year.nil? || month.nil? || day.nil?
    if year != worked_in_at.year || month != worked_in_at.month || day != worked_in_at.day
      errors[:base] << '出勤年月日がタイムカードの日付と違います。また、日付をまたいだ日時は記録できません。'
    elsif year != worked_out_at.year || month != worked_out_at.month || day != worked_out_at.day
      errors[:base] << '退勤年月日がタイムカードの日付と違います。また、日付をまたいだ日時は記録できません。'
    elsif year != breaked_in_at.year || month != breaked_in_at.month || day != breaked_in_at.day
      errors[:base] << '休憩開始年月日がタイムカードの日付と違います。また、日付をまたいだ日時は記録できません。'
    elsif year != breaked_out_at.year || month != breaked_out_at.month || day != breaked_out_at.day
      errors[:base] << '休憩終了年月日がタイムカードの日付と違います。また、日付をまたいだ日時は記録できません。'
    end
  end
end