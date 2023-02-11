# frozen_string_literal: true

require 'csv'

# 4518 airports
airports = CSV.open('lib/airports_medium_large.csv', headers: true, header_converters: :symbol)
airports = airports.filter { |a| a[:iata_code] }
airports.each do |a|
  Airport.create code: a[:iata_code], name: a[:municipality], region: a[:continent], country_code: a[:iso_country], latitude: a[:latitude_deg],
                 longitude: a[:longitude_deg]
end

start_time = Time.now

# ~60k routes total
# 14695 in EU
routes = CSV.open('lib/routes_EU.dat', headers: true, header_converters: :symbol)
routes.each do |route|
  departure_airport = Airport.find_by code: route[:departure_airport_iata]
  arrival_airport = Airport.find_by code: route[:arrival_airport_iata]

  next unless departure_airport && arrival_airport

  rand(3..5).times do |n|
    Flight.create departure_airport:, arrival_airport:, start: Time.now + (n + 1).days, duration: 4.hours
  end
end

puts Time.now - start_time
print Flight.count
puts ' flights'
