require 'rails_helper'

RSpec.describe '所属登録・削除・編集機能テスト', type: :system do
  before do
    FactoryBot.create(:affiliation_1)
    FactoryBot.create(:affiliation_2)
    FactoryBot.create(:user_1)
    FactoryBot.create(:user_2)
    FactoryBot.build(:timecard_1)

    visit  new_user_session_path
    fill_in 'メールアドレス', with: 'test_1@a.com'
    fill_in 'パスワード', with: 'hogehoge'
    click_on 'Log in'
  end

  describe '所属' do
    context '所属名入力テスト' do
      it 'データ保存後、所属一覧とメッセージが表示されること' do
        visit new_affiliation_path
        fill_in '所属', with: '新規所属'
        click_on('登録する')
        list = page.all('td')
        expect(list[1]).to have_content '新規所属'
        expect(page).to have_content '新しい所属を登録しました'
      end

      it 'データ編集後、所属一覧とメッセージが表示されること' do
        visit edit_affiliation_path(1)
        fill_in '所属', with: 'テスト'
        click_on('更新する')
        list = page.all('td')
        expect(list[8]).to have_content 'テスト'
        expect(page).to have_content '所属ID'
        expect(page).to have_content '所属を編集しました'
      end

      it '重複データの場合、エラーメッセージが表示されること' do
        visit new_affiliation_path
        fill_in '所属', with: '営業部'
        click_on('登録する')
        expect(page).to have_content 'エラーがあります'
        expect(page).to have_content '所属はすでに存在します'
      end

      it '所属従業員がいる場合、エラーメッセージが表示されること' do
        visit affiliations_path
        page.all('td')[6].click
        expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除しますか？"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '所属ユーザーまたは所属に紐付くタイムカードがあるため削除できません'
      end

      it '所属従業員がいる場合、エラーメッセージが表示されること' do
        FactoryBot.create(:affiliation_3)
        FactoryBot.create(:user_3)
        FactoryBot.create(:timecard_3)
        visit affiliations_path
        page.all('td')[20].click
        expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除しますか？"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '所属ユーザーまたは所属に紐付くタイムカードがあるため削除できません'
      end

      it '所属従業員・関連タイムカードがない場合、削除ができること' do
        FactoryBot.create(:affiliation_2,
                        id: 3,
                        name: 'テスト')
        visit affiliations_path
        page.all('td')[20].click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '所属を削除しました'
      end
    end
  end
end