class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property
  validates :number_of_nights, numericality: { only_integer: true }
  validates :number_of_guest, numericality: { only_integer: true }
  validates :total_price, numericality: true
end
