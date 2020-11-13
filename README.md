# アプリケーション名

* place（居場所という意味を込めています）

# アプリケーション概要

- ユーザー管理機能
- 投稿機能
- 投稿一覧表示機能
- 投稿詳細機能
- 投稿編集機能
- 投稿削除機能
- マイページ機能
- コメント機能
- コメント削除機能
- 検索機能

# アプリケーションURL

* [Place](http://54.95.238.168/)
* http://54.95.238.168/

# テスト用アカウント

* email   qq@qq
* PW      qqqqqq1

# 利用方法

* 未ログイン時は投稿の一覧を閲覧、他ユーザーのマイページの閲覧、検索機能を使用することができる
* ログイン時は上記に加え、新規投稿、コメント投稿・削除などができる

# 目指した課題解決

### 誰の？

* 悩みや不安を抱えていて、精神的に弱っている人

### どのような課題を解決？

* 気軽に悩みや不安を相談し、共感しあえる場所がない

# 実装予定の機能

* SNS認証
* いいね機能
* カテゴリー検索機能
* ゲストユーザー機能

# ローカルでの動作方法

```ruby
% git clone https://github.com/tanabe0624/support-app.git
% cd support-app
% bundle install
% yarn install
% rails db:create
% rails db:migrate
```

* Rubyバージョン:2.6.5

# テーブル設計

## users テーブル

| Column        | Type    | Options     |
| ------------- | ------- | ----------- |
| nickname      | string  | null: false |
| email         | string  | null: false |
| password      | string  | null: false |
| gender_id     | integer | null: false |
| age_id        | integer | null: false |
| occupation_id | integer | null: false |

### Association

- has_many :tweets
- has_many :comments

## tweets テーブル

| Column      | Type       | Option                         |
| ----------- | -----------| ------------------------------ |
| title       | string     | null: false                    |
| text        | text       | null: false                    |
| category_id | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

## comments テーブル

| Column | Type       | Option                         |
| ------ | -----------| ------------------------------ |
| text   | string     | null: false                    |
| user   | references | null: false, foreign_key: true |
| tweet  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :tweet
