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
| text        | string     | null: false                    |
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
