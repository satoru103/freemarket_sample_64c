# README

## freemarket_sample_64c
フリマアプリのクローンサイト

## Description
フリマアプリのクローンサイト
誰でも自由に商品を出品と購入ができます。

## Function
・haml/SASS記法と、命名規則BEMを使ったマークアップ  
・deviseを使用したユーザ登録機能  
・ancestroyを使用した多階層カテゴリの登録機能  
・active_hashを使用したデータ登録機能  
・pay.jpによるクレジットカード登録機能、クレジット決済機能  
・capistranoによるAWS EC2への自動デプロイ  
・ActiveStorageを使用しAWS S3への画像アップロード

## environment
・Ruby 2.5.1  
・Rails 5.2.3


## freemarket DB設計

## usersテーブル
|Column|Type|Options|Index|
|------|----|-------|-----|
|first_name     |string    |null: false|
|last_name      |string    |null: false|
|first_name_kana|string    |null: false|
|last_name_kana |string    |null: false|
|nickname       |string    |null: false|
|email          |string    |null: false, unique:ture|○|
|birthday       |date      |null: false|
|phone_number   |string    |  |
|introduction   |text      |  |
### Association
- has_one :addrres
- has_many :comments
- has_many :items
- has_one :card

## addrresテーブル
|Column|Type|Options|
|------|----|-------|
|destination_first_name     |string    |null: false|
|destination_last_name      |string    |null: false|
|destination_first_name_kana|string    |null: false|
|destination_first_name_kana|string    |null: false|
|post_number                |string    |null: false|
|prefecture                 |integer   |null: false|
|city                       |string    |null: false|
|house_number               |string    |null: false|
|building                   |string    |  |
|user                       |refarences|foreign_key: true|
### Association
- belongs_to :user

## cardテーブル
|Column|Type|Options|
|------|----|-------|
|card_id|string    |  |
|user   |references|null: false, foreign_key:true|
|customer_id|string|null: false|
### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Options|Index|
|------|----|-------|-----|
|item_name      |string    |null: false|○|
|price          |interger  |null: false|
|discription    |text      |null: false|
|user           |references|null: false, foreign_key: true|
|category       |refarences|null: false, foreign_key: true|
|brand          |refarences|foreign_key: true|
|size           |interger  |null: false|
|status         |interger|null: false| 
|delivery_charge_id|interger|null: false|
|area_id        |interger  |null: false|
|shipping_date_id  |interger|null: false|
|shipping_method_id|interger|null: false|
|seller_id      |interger  |null: false|
|buyer_id       |interger  |null: false|
|item_status    |interger  |null: false|

### Association
- belongs_to :user
- belongs_to :brand
- belongs_to :category
- has_many :comments
- has_many :pictures
- belongs_to_active_hash :status
- belongs_to_active_hash :
- belongs_to_active_hash :shipping_date  
- belongs_to_active_hash :shipping_method

## picturesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string    |  |
|item |refarences|foreign_key: true|
### Association
- belongs_to :item

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|main      |string|  |
|main_genre|string|  |
|genre_list|string|  |
### Association
- has_many :items

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|brand_name|string|  |
### Association
- has_many :items

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|body|text      |  |
|user|refarences|foreign_key|
|item|refarences|foreign_key|
### Association
- belongs_to :user
- belongs_to :item

## statusテーブル
|Column|Type|Options|
|------|----|-------|
|value|string|null: false|
### Association
- has_many :items

## delivery_chargeテーブル
|Column|Type|Options|
|------|----|-------|
|value|string|null: false|
### Association
- has_many :items

## shipping_dateテーブル
|Column|Type|Options|
|------|----|-------|
|value|string|null: false|
### Association
- has_many :items

## shipping_methodテーブル
|Column|Type|Options|
|------|----|-------|
|value|string|null: false|
### Association
- has_many :items