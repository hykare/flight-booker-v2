class FlightsController < ApplicationController
  def index
    @departure_airport_options = Airport.with_scheduled_departures.alphabetical.map { |a| ["#{a.name} (#{a.code})", a.id] }
    @arrival_airport_options = Airport.with_scheduled_arrivals.alphabetical.map { |a| ["#{a.name} (#{a.code})", a.id] }

    @dates = Flight.pluck(:start).map { |date| date.strftime('%d %b %Y') }.uniq
  end
end
