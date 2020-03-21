require 'rails_helper'

RSpec.describe Affiliation, type: :model do

  before do
    @affiliation = FactoryBot.create(:affiliation_1)
    @affiliation_2 = FactoryBot.create(:affiliation_2)
    @blank_name = FactoryBot.build(:affiliation_1, name: '')
    @user = FactoryBot.create(:user_1)
  end

  describe 'バリデーションテスト' do
    it '空のnameなら無効であること' do
      expect(@blank_name).not_to be_valid
    end

    it '重複したnameなら無効であること' do
      affiliation = Affiliation.new(
                          id: 3,
                          name: '営業部')
      expect(affiliation).not_to be_valid
    end

    it '20文字以上のnameなら無効であること' do
      affiliation = Affiliation.create(
                          id: 3,
                          name: 'a' * 21)
      expect(affiliation).not_to be_valid
    end
  end
end