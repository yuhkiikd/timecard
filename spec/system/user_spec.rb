require 'rails_helper'

RSpec.describe 'セッション機能、ユーザー登録・削除・編集機能', type: :system do
  before do
    FactoryBot.create(:affiliation_1)
    FactoryBot.create(:affiliation_2)
    FactoryBot.create(:user_1, id: 3)
    FactoryBot.create(:user_2)
    FactoryBot.build(:timecard_1)

    visit  new_user_session_path
    fill_in 'メールアドレス', with: 'test_1@a.com'
    fill_in 'パスワード', with: 'hogehoge'
    click_on 'Log in'
  end

  describe 'セッション機能' do
    context 'ログイン・ログアウトテスト' do
      it 'ログアウトして、ログイン出来ること' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウト済です'
        fill_in 'メールアドレス', with: 'test_1@a.com'
        fill_in 'パスワード', with: 'hogehoge'
        click_on 'Log in'
        expect(page).to have_content 'サインインしました'
      end

      it '登録にないメールアドレスならログイン無効なこと' do
        click_on 'ログアウト'
        fill_in 'メールアドレス', with: 'aaaaaaaa@a.com'
        fill_in 'パスワード', with: 'hogehoge'
        click_on 'Log in'
        expect(page).to have_content 'メールアドレスまたはパスワードが無効です。'
      end

      it '新規登録できること' do
        click_on '管理者メニュー'
        click_on 'ユーザー登録'
        sleep 3
        fill_in '名前', with: 'test_5'
        fill_in 'メールアドレス', with: 'test_5@a.com'
        fill_in 'パスワード', with: 'hogehoge'
        fill_in '確認用パスワード', with: 'hogehoge'
        select "営業部", from: "user[affiliation_id]"
        select "管理者", from: "user[admin]"
        click_on '登録する'
        expect(page).to have_content '確認メールを、登録したメールアドレス宛に送信しました。メールに記載されたリンクを開いてアカウントを有効にして下さい。'
      end
    end
  end
end