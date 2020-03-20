require 'rails_helper'

RSpec.describe TimeCard, type: :model do

  before do
    @affiliation = FactoryBot.create(:affiliation_1)
    @affiliation_2 = FactoryBot.create(:affiliation_2)
    @user = FactoryBot.create(:user_1)
    @user_2 = FactoryBot.create(:user_2)
    @timecard_1 = FactoryBot.build(:timecard_1)
  end

  describe 'バリデーションテスト' do
    # year
    it '空のyearなら無効であること' do
      @timecard_1.year = ''
      expect(@timecard_1).not_to be_valid
    end

    it '2020以前のyearなら無効であること' do
      @timecard_1.year = 2019
      expect(@timecard_1).not_to be_valid
    end

    it '文字列のyearなら無効であること' do
      @timecard_1.year = '２０２０'
      expect(@timecard_1).not_to be_valid
    end

    it '勤怠時間と違うyearなら無効であること' do
      @timecard_1.year = Time.current.year + 1
      expect(@timecard_1).not_to be_valid
    end

    # month
    it '空のmonthなら無効であること' do
      @timecard_1.month = ''
      expect(@timecard_1).not_to be_valid
    end

    it '0以下のmonthなら無効であること' do
      @timecard_1.month = 0
      expect(@timecard_1).not_to be_valid
    end

    it '13以上のmonthなら無効であること' do
      @timecard_1.month = 13
      expect(@timecard_1).not_to be_valid
    end

    it '文字列のmonthなら無効であること' do
      @timecard_1.month = '３'
      expect(@timecard_1).not_to be_valid
    end

    it '勤怠時間と違うmonthなら無効であること' do
      @timecard_1.month = Time.current.month + 1
      expect(@timecard_1).not_to be_valid
    end

    # day
    it '空のdayなら無効であること' do
      @timecard_1.day = ''
      expect(@timecard_1).not_to be_valid
    end

    it '0以下のdayなら無効であること' do
      @timecard_1.day = 0
      expect(@timecard_1).not_to be_valid
    end

    it '31以上のdayなら無効であること' do
      @timecard_1.day = 32
      expect(@timecard_1).not_to be_valid
    end

    it '勤怠時間と違うdayなら無効であること' do
      @timecard_1.day = Time.current.month + 1
      expect(@timecard_1).not_to be_valid
    end

    # 勤怠時間
    it '空のworked_timeなら無効であること' do
      @timecard_1.worked_time = ''
      expect(@timecard_1).not_to be_valid
    end

    it '0未満のworked_timeなら無効であること' do
      @timecard_1.worked_time = -1
      expect(@timecard_1).not_to be_valid
    end

    it '空のbreaked_timeなら無効であること' do
      @timecard_1.breaked_time = ''
      expect(@timecard_1).not_to be_valid
    end

    it '0未満のbreaked_timeなら無効であること' do
      @timecard_1.breaked_time = -1
      expect(@timecard_1).not_to be_valid
    end

    it '空のovertimeなら無効であること' do
      @timecard_1.overtime = ''
      expect(@timecard_1).not_to be_valid
    end

    it '0未満のovertimeなら無効であること' do
      @timecard_1.overtime = -1
      expect(@timecard_1).not_to be_valid
    end

    it '空のworked_in_atなら無効であること' do
      @timecard_1.worked_in_at = ''
      expect(@timecard_1).not_to be_valid
    end

    it '空のaffiliation_idなら無効であること' do
      @timecard_1.affiliation_id = ''
      expect(@timecard_1).not_to be_valid
    end

    it '0以下のaffiliation_idなら無効であること' do
      @timecard_1.affiliation_id = 0
      expect(@timecard_1).not_to be_valid
    end

    it '空のuser_idなら無効であること' do
      @timecard_1.user_id = ''
      expect(@timecard_1).not_to be_valid
    end

    it '0以下のuser_idなら無効であること' do
      @timecard_1.user_id = 0
      expect(@timecard_1).not_to be_valid
    end
  end

  describe '勤怠時間差テスト' do
    # 出勤日時　＜　休憩開始日時　＜　休憩終了日時　＜　退勤日時でなければ無効
    it 'worked_in_atがworked_out_atよりあとなら無効であること' do
      @timecard_2 = FactoryBot.build(:timecard_2) 
      @timecard_2.worked_in_at = '2020-03-02 19:00:00'
      expect(@timecard_2).not_to be_valid
    end

    it 'worked_in_atがbreaked_in_atよりあとかつ、breaked_out_atより前なら無効であること' do
      @timecard_2 = FactoryBot.build(:timecard_2) 
      @timecard_2.worked_in_at = '2020-03-02 14:30:00'
      expect(@timecard_2).not_to be_valid
    end

    it 'worked_in_atがbreaked_out_atよりあとなら無効であること' do
      @timecard_2 = FactoryBot.build(:timecard_2) 
      @timecard_2.worked_in_at = '2020-03-02 15:30:00'
      expect(@timecard_2).not_to be_valid
    end

    it 'breaked_in_atがbreaked_out_atよりあとなら無効であること' do
      @timecard_2 = FactoryBot.build(:timecard_2) 
      @timecard_2.breaked_in_at = '2020-03-02 16:10:00'
      expect(@timecard_2).not_to be_valid
    end

    it 'breaked_in_atがworked_out_atよりあとなら無効であること' do
      @timecard_2 = FactoryBot.build(:timecard_2) 
      @timecard_2.breaked_in_at = '2020-03-02 18:10:00'
      expect(@timecard_2).not_to be_valid
    end

    it 'breaked_out_atがworked_out_atよりあとなら無効であること' do
      @timecard_2 = FactoryBot.build(:timecard_2) 
      @timecard_2.breaked_out_at = '2020-03-02 18:10:00'
      expect(@timecard_2).not_to be_valid
    end

    it '日付をまたいだ勤務時間は無効であること' do
      @timecard_2 = FactoryBot.build(:timecard_2) 
      @timecard_2.worked_in_at = '2020-02-29 23:10:00'
      expect(@timecard_2).not_to be_valid
    end
  end
end