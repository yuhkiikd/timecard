require 'rails_helper'

RSpec.describe '出退勤時間記録・編集・削除テスト', type: :system do
  before do
    FactoryBot.create(:affiliation_1)
    FactoryBot.create(:affiliation_2)
    FactoryBot.create(:user_1)
    FactoryBot.create(:user_2)

    visit new_user_session_path
    fill_in 'メールアドレス', with: 'test_1@a.com'
    fill_in 'パスワード', with: 'hogehoge'
    click_on 'Log in'
    visit new_time_card_path
  end

  describe 'タイムカード機能' do
    context '勤怠時間記録テスト' do
      it '出勤前は出勤ボタンしか押せないこと' do
        expect(find('#worked_in')).not_to be_disabled
        expect(find('#breaked_in')).to be_disabled
        expect(find('#breaked_out')).to be_disabled
        expect(find('#worked_out')).to be_disabled
      end

      it '出勤ボタンを押すと時間が記録され、休憩開始と退勤ボタンが押せるようになること' do
        click_on 'worked_in'
        expect(page).to have_content '勤怠データを記録しました'
        visit new_time_card_path
        expect(find('#worked_in')).to be_disabled
        expect(find('#breaked_in')).not_to be_disabled
        expect(find('#breaked_out')).to be_disabled
        expect(find('#worked_out')).not_to be_disabled
      end

      it '休憩開始ボタンを押すと時間が記録され、休憩終了ボタンだけが押せる状態になること' do
        visit new_time_card_path
        click_on 'worked_in'
        visit new_time_card_path
        click_on 'breaked_in'
        expect(page).to have_content '勤怠データを記録しました'
        visit new_time_card_path
        expect(find('#worked_in')).to be_disabled
        expect(find('#breaked_in')).to be_disabled
        expect(find('#breaked_out')).not_to be_disabled
        expect(find('#worked_out')).to be_disabled
      end

      it '休憩終了ボタンを押すと、退勤ボタンだけが押せる状態になること' do
        visit new_time_card_path
        click_on 'worked_in'
        visit new_time_card_path
        click_on 'breaked_in'
        visit new_time_card_path
        click_on 'breaked_out'
        expect(page).to have_content '勤怠データを記録しました'
        visit new_time_card_path
        expect(find('#worked_in')).to be_disabled
        expect(find('#breaked_in')).to be_disabled
        expect(find('#breaked_out')).to be_disabled
        expect(find('#worked_out')).not_to be_disabled
      end

      it '退勤ボタンを押すと確認メッセージが表示され、OKをして記録すると全てのボタンが押せなくなること' do
        visit new_time_card_path
        click_on 'worked_in'
        visit new_time_card_path
        click_on 'breaked_in'
        visit new_time_card_path
        click_on 'breaked_out'
        visit new_time_card_path
        click_on 'worked_out'
        expect(page.driver.browser.switch_to.alert.text).to eq "※退勤処理をしてもよろしいですか？"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '勤怠データを記録しました'
        visit new_time_card_path
        expect(find('#worked_in')).to be_disabled
        expect(find('#breaked_in')).to be_disabled
        expect(find('#breaked_out')).to be_disabled
        expect(find('#worked_out')).to be_disabled
      end

      it '休憩ボタンを押さずに退勤ボタンを押すと、全てのボタンが押せなくなること' do
        visit new_time_card_path
        click_on 'worked_in'
        visit new_time_card_path
        click_on 'worked_out'
        expect(page.driver.browser.switch_to.alert.text).to eq "※退勤処理をしてもよろしいですか？"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '勤怠データを記録しました'
        visit new_time_card_path
        expect(find('#worked_in')).to be_disabled
        expect(find('#breaked_in')).to be_disabled
        expect(find('#breaked_out')).to be_disabled
        expect(find('#worked_out')).to be_disabled
      end

      it 'いずれかの出退勤時間登録をすると、勤怠状況一覧に名前と勤務状況が表示されること' do
        visit new_time_card_path
        click_on 'worked_in'
        expect(page).to have_content '勤怠データを記録しました'
        visit status_users_path
        expect(page.all('td')[1]).to have_content '勤務中'
        visit new_time_card_path
        click_on 'breaked_in'
        expect(page).to have_content '勤怠データを記録しました'
        visit status_users_path
        expect(page.all('td')[1]).to have_content '休憩中'
        visit new_time_card_path
        click_on 'breaked_out'
        expect(page).to have_content '勤怠データを記録しました'
        visit status_users_path
        expect(page.all('td')[1]).to have_content '勤務中'
        visit new_time_card_path
        click_on 'worked_out'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '勤怠データを記録しました'
        visit status_users_path
        expect(page.all('td')[1]).to have_content '退社済'
      end
    end

    context '勤怠時間編集・削除テスト' do
      it '退勤前は編集ができないこと' do
        visit new_time_card_path
        click_on 'worked_in'
        visit all_index_time_cards_path
        page.all('td')[10].click
        expect(page).to have_content '編集は退勤時間を記録してから可能です。'
      end

      it 'タイムカードの削除が可能なこと' do
        visit new_time_card_path
        click_on 'worked_in'
        visit all_index_time_cards_path
        page.all('td')[11].click
        expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除してもよろしいですか？"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '勤怠データを削除しました！'
      end

      it '退勤時間を記録すると、タイムカードの編集が可能なこと' do
        visit new_time_card_path
        click_on 'worked_in'
        visit new_time_card_path
        click_on 'worked_out'
        page.driver.browser.switch_to.alert.accept
        visit all_index_time_cards_path
        page.all('td')[10].click
        expect(page).to have_content 'タイムカード編集'
      end

      it '出勤日時　＜　休憩開始日時　＜　休憩終了日時　＜　退勤日時でなければエラーが起こること' do
        FactoryBot.create(:timecard_1)
        visit edit_time_card_path(1)
        expect(page).to have_content 'タイムカード編集'
        select '14', from: 'time_card[worked_in_at(4i)]'
        select '30', from: 'time_card[worked_in_at(5i)]'
        click_on '休憩ありで更新する'
        expect(page).to have_content '1 件のエラーがあります。'
        expect(page).to have_content '出勤日時　＜　休憩開始日時　＜　休憩終了日時　＜　退勤日時で入力してください'
        visit edit_time_card_path(1)
        select '15', from: 'time_card[breaked_in_at(4i)]'
        select '30', from: 'time_card[breaked_in_at(5i)]'
        click_on '休憩ありで更新する'
        expect(page).to have_content '出勤日時　＜　休憩開始日時　＜　休憩終了日時　＜　退勤日時で入力してください'
        visit edit_time_card_path(1)
        select '15', from: 'time_card[breaked_in_at(4i)]'
        select '30', from: 'time_card[breaked_in_at(5i)]'
        click_on '休憩ありで更新する'
        expect(page).to have_content '出勤日時　＜　休憩開始日時　＜　休憩終了日時　＜　退勤日時で入力してください'
      end
    end

    context '残業時間表示テスト' do
      it '残業時間と実働時間が表示されること' do
        FactoryBot.create(:timecard_1, :overtime)
        visit user_path(1)
        expect(page.all('td')[4]).to have_content '9:00'
        expect(page.all('td')[5]).to have_content '1:00'
      end

      it '所属一覧に残業時間と従業員数が表示されること' do
        FactoryBot.create(:timecard_1, :overtime)
        visit affiliations_path
        expect(page.all('td')[9]).to have_content '1'
        expect(page.all('td')[10]).to have_content '1時間'
      end

      it '所属詳細に従業員数・所属が表示されること' do
        FactoryBot.create(:timecard_1, :overtime)
        visit affiliation_path(1)
        expect(page).to have_content '所属人数：1'
      end
    end
  end
end