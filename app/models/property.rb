class Property < ApplicationRecord
  has_many :pictures, dependent: :destroy
  has_many :reservations, dependent: :destroy
  validates :price_per_night, presence: true
  belongs_to :user
end
