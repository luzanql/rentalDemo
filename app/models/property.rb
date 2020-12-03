class Property < ApplicationRecord
  has_many :pictures, dependent: :destroy
  has_many :reservations, dependent: :destroy
  validates :price_per_night, presence: true
  validates :price_per_night, numericality: true
  belongs_to :user
end
