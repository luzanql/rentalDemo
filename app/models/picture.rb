class Picture < ApplicationRecord
  belongs_to :property
  has_one_attached :image
  validates :image, presence: true
end
