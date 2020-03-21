# README

# タイムカードプラス

## 概要
出退勤時間を管理して残業時間などをグラフで表示し、業務改善の指標とするアプリ

## コンセプト
タイムカードをアプリにする
集まった出退勤データをグラフにする

## バージョン
Ruby 2.6.5
Rails 5.2.3

## 機能一覧
- [ ] ログイン機能
  - [ ] 認証メッセージの通知機能（ユーザー登録時に確認メッセージが届く）
- [ ] ダッシュボード機能
  - [ ]※ダッシュボードは主にデータの一括管理を目出とする。
  - [ ]データをcsvでダウンロードしたり、退勤記録・従業員・所属を一括で消す必要がある場合などを想定
  - [ ]ダッシュボードからのみ管理者が2人以上の際に、自身の削除・権限の変更が可能（従業員一覧編集からは不可）
- [ ] ページ閲覧制限機能（管理者権限の有無、またはログイン状態有無でページの閲覧制限）
- [ ] 従業員登録機能（管理者のみ）
  - [ ] メールアドレス、名前、パスワード、所属（グループ）は必須
- [ ] 従業員一覧表示機能（管理者のみ）
  - [] 各従業員の権限・所属も表示
- [ ] 従業員削除機能（管理者のみ）
- [ ] 従業員編集機能（管理者のみ）
- [ ] 出退勤時間登録機能
  - [ ] ボタンひとつで出退勤のデータが入力できる機能
  - [ ] 残業時間は法定労働時間（8時間）に基づいて算出
- [ ] 出退勤時間編集機能（管理者のみ）
  - [ ] 編集は退勤時間を打刻してからのみ可能
- [ ] 出退勤時間削除機能（管理者のみ）
- [ ] マイページ機能
  - [ ] 当月残業時間表示・グラフ化機能
    - [ ] 自身の残業時間をグラフとして見られる
    - [ ] 管理者は全従業員を見ることが可能
  - [ ] 当月実働時間表示化機能
    - [ ] 自身の実働時間を見られる
    - [ ] 管理者は全従業員を見ることが可能
- [ ] 所属（グループ）作成機能（管理者のみ）
  - [ ] 従業員が所属するグループを登録
- [ ] 所属（グループ）編集機能（管理者のみ）
- [ ] 所属（グループ）削除機能（管理者のみ）
- [ ] 所属（グループ）一覧機能（管理者のみ）
  - [ ] 所属（グループ）の従業員数・当月の残業時間を一覧で表示
  - [ ] 従業員の所属（グループ）が変更された場合は、打刻時の所属に対する残業時間が反映される(従業員数は変更)
- [ ] 所属（グループ）詳細機能（管理者のみ）
  - [ ]所属（グループ）詳細では所属ごとのデータを数値またはグラフで表示
    - [ ]従業員の所属（グループ）が変更された場合は、打刻時の所属に対する残業時間が反映される

## カタログ設計
https://docs.google.com/spreadsheets/d/19XPVKREsyzAYJVSWJw8Rdpyv_hexUJbH3jKuQCv8J3c/edit#gid=0

## テーブル定義
https://docs.google.com/spreadsheets/d/19XPVKREsyzAYJVSWJw8Rdpyv_hexUJbH3jKuQCv8J3c/edit#gid=1374642052

## 画面遷移図
https://docs.google.com/spreadsheets/d/19XPVKREsyzAYJVSWJw8Rdpyv_hexUJbH3jKuQCv8J3c/edit#gid=442311407

## 画面ワイヤーフレーム
https://cacoo.com/diagrams/yXLn5boDwjAXRTKO/F2624

## E-R図
https://docs.google.com/spreadsheets/d/19XPVKREsyzAYJVSWJw8Rdpyv_hexUJbH3jKuQCv8J3c/edit#gid=533799659

## 使用予定Gem
* chart-js-rails または　Chartkick
* haml-rails
* devise
* omniauth
* omniauth-google-oauth2
