class Booking < ApplicationRecord
  has_many :passengers
  belongs_to :flight_offer

  accepts_nested_attributes_for :passengers
end
