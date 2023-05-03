class Restaurant < ApplicationRecord
  has_many :bookings
  
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
end
