require 'rails_helper'

RSpec.describe 'ユーザー登録・ログイン・ログアウト機能' do
  before do
    @affiliation = FactoryBot.create(:affiliation_1)
    @affiliation_2 = FactoryBot.create(:affiliation_2)
    @user = FactoryBot.create(:user_1)
    @user_2 = FactoryBot.create(:user_2)
    @timecard_1 = FactoryBot.build(:timecard_1)

    visit  new_user_session_path
    fill_in 'Email', with: 'test_1@a.com'
    fill_in 'Password', with: 'hogehoge'
    click_on 'Log in'
  end

  describe '所属' do
    context '所属名を入力し、登録ボタンを押下した場合' do
      it 'データ保存後、タスク一覧に表示されること' do
        visit new_label_path
        fill_in 'label[label_type]', with: 'デバッグ'
        click_on('登録する')
        sleep 2
        task_list = page.all('tr')
        expect(task_list[1]).to have_content 'デバッグ'
      end
      
      it '空白のラベルは作成できないこと' do
        visit new_label_path
        click_on('登録する')
        expect(page).to have_content 'ラベル名を入力してください'
      end
    end
  end

end