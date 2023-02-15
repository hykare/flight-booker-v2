FactoryBot.define do
  factory :flight do
    departure_airport_id { Airport.first.id }
    arrival_airport_id { Airport.last.id }
    start { Time.now }
    duration { 4.hours }
  end
end
