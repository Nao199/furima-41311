## テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false ,unique: true |
| encrypted_password | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| first_name_kana    | string | null: false |
| last_name_kana     | string | null: false |
| birth_date         | date   | null: false |



### Association

- has_many :items
- has_many :orders 

## items テーブル

| Column                 | Type       | Options     |
| ---------------------- | ---------- | ----------- |
| name                   | string     | null: false |
| description            | text       | null: false |
| category_id            | integer    | null: false |
| condition_id           | integer    | null: false |
| shipping_fee_status_id | integer    | null: false |
| prefecture_id          | integer    | null: false |
| shipping_day_id        | integer    | null: false |
| price                  | integer    | null: false |
| user_id                | references | null: false, foreign_key:true |


### Association

- belongs_to :users
- has_one :orders


## orders テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| order        | integer    | null: false                    |
| user_id      | references | null: false, foreign_key: true |
| item_id      | references | null: false, foreign_key: true |
| purchased_at | datetime   | null: false                    |

### Association

- belongs_to :users
- belongs_to :items
- has_one :shipping_addresses


## shipping_addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | string     | null: false                    |
| city          | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| order_id      | references | null: false, foreign_key: true |


### Association

- belongs_to :orders