class Airport < ApplicationRecord
  has_many :departing_flights, foreign_key: 'departure_airport_id', class_name: 'Flight'
  has_many :arriving_flights, foreign_key: 'arrival_airport_id', class_name: 'Flight'

  reverse_geocoded_by :latitude, :longitude

  scope :alphabetical, -> { order(name: :asc) }
  scope :with_scheduled_arrivals, -> { distinct.joins(:arriving_flights) }
  scope :with_scheduled_departures, -> { distinct.joins(:departing_flights) }

  def name_iata
    "#{name} (#{code})"
  end
end
