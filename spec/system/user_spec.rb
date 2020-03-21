require 'rails_helper'

RSpec.describe 'セッション機能、ユーザー登録・削除・編集機能', type: :system do
  before do
    FactoryBot.create(:affiliation_1)
    FactoryBot.create(:affiliation_2)
    FactoryBot.create(:user_1, id: 3)
    @user_2 = FactoryBot.create(:user_2, id: 2)
    FactoryBot.create(:timecard_1, id: 1, user_id: 3)
    FactoryBot.create(:timecard_2, id: 2, user_id: 2)

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

      it '一般権限でログインすると管理者メニューが非表示なっていること' do
        click_on 'ログアウト'
        fill_in 'メールアドレス', with: 'test_2@a.com'
        fill_in 'パスワード', with: 'hogehoge'
        click_on 'Log in'
        expect(page).not_to have_content '管理者メニュー'
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

    context '編集・削除機能' do
      it '編集画面で自身の編集削除ができないこと' do
        visit users_path
        page.all('td')[14].click
        expect(page).to have_content '管理者は他の管理者から編集・削除をしてください'
        page.all('td')[15].click
        expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除してもよろしいですか？"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '管理者は他の管理者から編集・削除をしてください'
      end

      it '編集でき、従業員一覧が表示される・マイページの名前が変わること' do
        visit users_path
        page.all('td')[6].click
        fill_in '名前', with: 'test_change_2'
        fill_in 'メールアドレス', with: 'test_2@a.com'
        fill_in 'パスワード', with: 'hogehoge'
        fill_in '確認用パスワード', with: 'hogehoge'
        select "営業部", from: "user[affiliation_id]"
        select "一般", from: "user[admin]"
        click_on '更新する'
        expect(page).to have_content 'ユーザー情報を更新しました'
        expect(page).to have_content '従業員一覧'
        visit users_path
        page.all('td')[5].click
        expect(page).to have_content 'test_change_2 さんの従業員情報'
      end

      it 'ユーザーを削除するとメッセージが表示されること' do
        visit users_path
        page.all('td')[7].click
        expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除してもよろしいですか？"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ユーザーを削除しました'
      end

      it 'ユーザーを削除すると紐づいたタイムカードも削除されること' do
        expect { @user_2.destroy }.to change { TimeCard.count }.by(-1)
      end
    end

    context '一般権限テスト' do
      it '管理者権限が必要なページが表示されないこと' do
        click_on 'ログアウト'
        fill_in 'メールアドレス', with: 'test_2@a.com'
        fill_in 'パスワード', with: 'hogehoge'
        click_on 'Log in'

        #ダッシュボード
        visit rails_admin_path
        expect(page).to have_content 'You are not authorized to access this page'
        #所属一覧
        visit affiliations_path
        expect(page).to have_content '管理者権限がありません'
        #所属詳細
        visit affiliation_path(1)
        expect(page).to have_content '管理者権限がありません'
        #所属編集
        visit edit_affiliation_path(1)
        expect(page).to have_content '管理者権限がありません'
        #所属新規登録
        visit new_affiliation_path
        expect(page).to have_content '管理者権限がありません'
        #従業員一覧
        visit users_path
        expect(page).to have_content '管理者権限がありません'
        #自分以外の従業員詳細
        visit user_path(1)
        expect(page).to have_content 'アクセス権がありません'
        #従業員新規登録
        visit new_user_registration_path
        expect(page).to have_content '管理者権限がありません'
        #従業員勤務状況
        visit status_users_path
        expect(page).to have_content '管理者権限がありません'
        #全タイムカード一覧
        visit all_index_time_cards_path
        expect(page).to have_content '管理者権限がありません'
        #タイムカード編集
        visit edit_time_card_path(1)
        expect(page).to have_content '管理者権限がありません'
      end
    end

    context '人数表示テスト' do
      it '所属一覧に残業時間と従業員数が表示されること' do
        FactoryBot.create(:timecard_1, :other_day, id: 5, user_id: 3)
        visit affiliations_path
        expect(page.all('td')[1]).to have_content '営業部'
        expect(page.all('td')[2]).to have_content '1'
        expect(page.all('td')[3]).to have_content '1時間'
      end

      it '所属詳細に従業員数・所属が表示されること' do
        visit affiliation_path(1)
        expect(page).to have_content '所属人数：1'
        expect(page).to have_content '所属：営業部'
      end
    end
  end
end