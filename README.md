# テーブル設計

## usersテーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false |
| encrypted_password | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| last_name_kana     | string  | null: false |
| first_name_kana    | string  | nill: false |
| birthday           | date    | null: false |


### Association

- has_many :items
- has_many :logs

## itemsテーブル

| Column             | Type       | Options           |
| -------------------| ---------- | ----------------- |
| name               | string     | null: false       |
| description        | text       | null: false       |
| category_id        | integer    | null: false       |
| condition_id       | integer    | null: false       |
| shipping_fee_id    | integer    | null: false       |
| prefecture_id      | integer    | null: false       |
| shipment_date_id   | integer    | null: false       |
| price              | integer    | null: false       |
| user               | references | foreign_key: true |

### Association

- belongs_to :user
- has_one :log

## ordersテーブル

| Column        | Type       | Options           |
| --------------| ---------- | ----------------- |
| postal_code   | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| address_line1 | string     | null: false       |
| address_line2 | string     |                   |
| phone_number  | string     | null: false       |
| log           | references | foreign_key: true |

### Association
- belongs_to : log

## logsテーブル

| Column    | Type       | Options           |
| --------- | ---------- | ----------------- |
| user      | references | foreign_key: true |
| item      | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :order