class Booking < ApplicationRecord
  belongs_to :restaurant

  validates :date, presence: true
  validates :restaurant_id, presence: true

  RES_TABLES = 3
  DAY_TABLES = 5
end
