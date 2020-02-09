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
- [ ] OAuth認証
 - [ ] 認証メッセージの通知機能
- [ ] 従業員登録機能
  - [ ] メールアドレス、名前、パスワード、所属（グループ）は必須
- [ ] 従業員一覧表示機能（管理者のみ）
  - [ ] 従業員数を表示
- [ ] 従業員削除機能
- [ ] 従業員編集機能
- [ ] 出退勤時間登録機能
  - [ ] ボタンひとつで出退勤のデータが入力できる機能
- [ ] 出退勤時間編集機能（管理者のみ）
- [ ] 出退勤時間削除機能（管理者のみ）
- [ ] 残業時間グラフ化機能
  - [ ] 自身の残業時間をグラフとして見られる
  - [ ] 管理者は全従業員を見ることが可能
- [ ] 所属（グループ）作成機能（管理者のみ）
  - [ ] 従業員が所属するグループを登録
- [ ] 所属（グループ）編集機能（管理者のみ）
- [ ] 所属（グループ）削除機能（管理者のみ）
- [ ] 所属（グループ）一覧機能（管理者のみ）
- [ ] 所属（グループ）詳細機能（管理者のみ）
  - [ ]所属（グループ）詳細では所属している従業員のデータ（人数・総勤務時間など）をグラフで表示

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
