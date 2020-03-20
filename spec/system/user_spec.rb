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

  describe 'セッション・レジストレーション機能' do
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
    end
    
    context '新規登録機能' do
      it '新規登録ができ、従業員一覧が表示されること' do
        click_on '管理者メニュー'
        click_on '従業員登録'
        fill_in '名前', with: 'test_5'
        fill_in 'メールアドレス', with: 'test_5@a.com'
        fill_in 'パスワード', with: 'hogehoge'
        fill_in '確認用パスワード', with: 'hogehoge'
        select "営業部", from: "user[affiliation_id]"
        select "管理者", from: "user[admin]"
        click_on '登録する'
        expect(page).to have_content '確認メールを、登録したメールアドレス宛に送信しました。メールに記載されたリンクを開いてアカウントを有効にして下さい。'
        click_on '管理者メニュー'
        click_on '従業員一覧'
        expect(page).to have_content 'test_5'
      end

      it '新規登録画面でブランク入力ならエラーメッセージが出ること' do
        click_on '管理者メニュー'
        click_on '従業員登録'
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in '確認用パスワード', with: ''
        click_on '登録する'
        expect(page).to have_content '5 件のエラーがあります。'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'メールアドレスは不正な値です'
        expect(page).to have_content 'パスワードを入力してください'
        expect(page).to have_content '所属を入力してください'
        expect(page).to have_content '名前を入力してください'
      end

      it '新規登録画面でパスワードと確認用パスワードが異なる・文字数が7文字以下ならエラーメッセージが出ること' do
        click_on '管理者メニュー'
        click_on '従業員登録'
        fill_in '名前', with: 'test_5'
        fill_in 'メールアドレス', with: 'test_5@a.com'
        fill_in 'パスワード', with: 'hogeho'
        fill_in '確認用パスワード', with: 'hogehoge'
        select "営業部", from: "user[affiliation_id]"
        select "管理者", from: "user[admin]"
        click_on '登録する'
        expect(page).to have_content '2 件のエラーがあります。'
        expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
        expect(page).to have_content 'パスワードは8文字以上で入力してください'
      end
    end

    context '編集機能' do
      it '編集画面で自身の編集削除ができないこと' do
        visit users_path
        page.all('td')[14].click
        expect(page).to have_content '管理者は他の管理者から編集・削除をしてください'
        page.all('td')[15].click
        expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除してもよろしいですか？"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '管理者は他の管理者から編集・削除をしてください'
      end
    end
  end
end