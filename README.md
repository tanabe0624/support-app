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
- いいね機能

# Demo

![新規投稿](https://user-images.githubusercontent.com/71654670/99866332-d07f8f00-2bf3-11eb-8f03-9ea94ea692a1.gif)

![投稿一覧表示、詳細、編集、削除](https://user-images.githubusercontent.com/71654670/99866260-16882300-2bf3-11eb-86ec-0ec752adc71a.gif)

![マイページ](https://user-images.githubusercontent.com/71654670/99866408-41bf4200-2bf4-11eb-9031-af149b475b0a.gif)

![コメント機能](https://user-images.githubusercontent.com/71654670/99866440-821ec000-2bf4-11eb-9c3b-5a949c066a82.gif)

![検索機能](https://user-images.githubusercontent.com/71654670/99866507-138e3200-2bf5-11eb-92a9-0504306f5488.gif)

![いいね機能](https://user-images.githubusercontent.com/71654670/99866469-babe9980-2bf4-11eb-8387-c2d07709745e.gif)

# アプリケーションURL

* http://54.95.238.168/

# テスト用アカウント

* email   qq@qq
* PW      qqqqqq1

# 利用方法

* 未ログイン時は投稿の一覧を閲覧、他ユーザーのマイページの閲覧、検索機能を使用することができる
* ログイン時は上記に加え、新規投稿・編集・削除、コメント投稿・削除、いいねなどができる

# 目指した課題解決

### 誰の？

* 悩みや不安を抱えていて、精神的に弱っている人

### どのような課題を解決？

* 気軽に悩みや不安を相談し、共感しあえる場所がない

# 実装予定の機能

* Dockerを開発環境に導入する
* カテゴリー検索機能

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

## ER図
![ER図](https://i.gyazo.com/60918799be51158891e0d0aeeb176144.png)


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
- has_many :likes

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
- has_many :likes

## comments テーブル

| Column | Type       | Option                         |
| ------ | -----------| ------------------------------ |
| text   | string     | null: false                    |
| user   | references | null: false, foreign_key: true |
| tweet  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :tweet

## likes テーブル

| Column | Type       | Option                         |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| tweet  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :tweet

