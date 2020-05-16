class Item < ApplicationRecord

  #active_hash
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :shipping_date
  belongs_to_active_hash :area


  #Association
  belongs_to :user
  has_many :comments
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true
  belongs_to :category

  #validation
  validates :price,:status,:delivery_charge_id,:area_id,:shipping_date_id, presence: true
  validates :item_name, presence: true, length: {maximum: 40}
  validates :discription, presence: true, length: {maximum: 1000}

  validates_associated :pictures
  validates :pictures, presence: true
  
  
end
