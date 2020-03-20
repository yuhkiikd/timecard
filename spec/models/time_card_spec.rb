require 'rails_helper'

RSpec.describe TimeCard, type: :model do

  before do
    @affiliation = FactoryBot.create(:affiliation_1)
    @affiliation_2 = FactoryBot.create(:affiliation_2)
    @user = FactoryBot.create(:user_1)
    @user_2 = FactoryBot.create(:user_2)
    @timecard_1 = FactoryBot.create(:timecard_1)
  end

  describe 'バリデーションテスト' do
    # yearテスト
    it '空のyearなら無効であること' do
      @timecard_1.year = ''
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

    # monthテスト
    it '空のmonthなら無効であること' do
      @timecard_1.month = ''
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

    # dayテスト
    it '空のdayなら無効であること' do
      @timecard_1.day = ''
      expect(@timecard_1).not_to be_valid
    end

    it '文字列のdayなら無効であること' do
      @timecard_1.day = '２０'
      expect(@timecard_1).not_to be_valid
    end

    it '勤怠時間と違うdayなら無効であること' do
      @timecard_1.day = Time.current.month + 1
      expect(@timecard_1).not_to be_valid
    end

    # 勤怠時間テスト
    it '空のworked_in_atなら無効であること' do
      @timecard_1.worked_in_at = ''
      expect(@timecard_1).not_to be_valid
    end

    it 'タイムカードと違う年のworked_in_atなら無効であること' do
      @timecard_1.worked_in_at = Time.current + 1
      expect(@timecard_1).not_to be_valid
    end
  end
end
