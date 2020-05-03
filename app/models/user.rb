class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ImageUploader

  has_many :items
  validates :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday, presence: true

  has_many :cards 
  has_one :address
end
