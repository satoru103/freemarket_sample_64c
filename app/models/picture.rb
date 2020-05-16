class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader

  #Association
  belongs_to :item
  validates :image, presence: true
end
