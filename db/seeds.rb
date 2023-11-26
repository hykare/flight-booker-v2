# frozen_string_literal: true

require 'csv'

# 4518 airports
airports = CSV.open('lib/airports_medium_large.csv', headers: true, header_converters: :symbol)
airports = airports.filter { |a| a[:iata_code] }
airports.each do |a|
  Airport.create code: a[:iata_code], name: a[:municipality], region: a[:continent], country_code: a[:iso_country], latitude: a[:latitude_deg],
                 longitude: a[:longitude_deg]
end
