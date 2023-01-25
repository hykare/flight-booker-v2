# frozen_string_literal: true

require 'csv'

airports = CSV.open('lib/airports.csv', headers: true, header_converters: :symbol)

airports = airports.filter { |a| a[:iata_code] && (a[:type] == 'large_airport' || a[:type] == 'medium_airport') }

puts airports.count

airports.first(100).each do |a|
  Airport.create code: a[:iata_code], name: a[:name], country_code: a[:iso_country], latitude: a[:latitude_deg],
                 longitude: a[:longitude_deg]
end
