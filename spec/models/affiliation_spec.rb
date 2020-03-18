require 'rails_helper'

RSpec.describe Affiliation, type: :model do

  before do
    @affiliation = FactoryBot.create(:affiliation_1)
    @blank_name = FactoryBot.build(:affiliation_1, name: "")
  end

  describe 'バリデーションテスト' do
    describe '単順項目' do
      it '空のnameなら無効であること' do
        @affiliation
        expect(@blank_name).not_to be_valid
      end

      it '重複したnameなら無効であること' do
        @affiliation
        affiliation = Affiliation.new(
                            id: 3,
                            name: '営業部')
        expect(affiliation).not_to be_valid
      end
    end


    describe '複数モデル関連' do
      it '所属の作成・削除が可能なこと' do
        affiliation = Affiliation.create(
                            id: 3,
                            name: '広報部')
        expect(affiliation).to be_valid
        destroy = affiliation.destroy
        expect(destroy).to be_valid
      end

      it '所属ユーザーがいる場合、削除できないこと' do
        @affiliation
        user = FactoryBot.create(:user_1)
        destroy = @affiliation.destroy
        expect(destroy).to be false
      end
    end
  end
end