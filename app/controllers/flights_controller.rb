class FlightsController < ApplicationController
  def index
    @departure_airport_options = Airport.with_scheduled_departures.alphabetical.map do |a|
      ["#{a.name} (#{a.code})", a.id]
    end
    @arrival_airport_options = Airport.with_scheduled_arrivals.alphabetical.map { |a| ["#{a.name} (#{a.code})", a.id] }
    @dates = Flight.pluck(:start).map { |date| date.strftime('%d %b %Y') }.uniq

    if params[:commit]
      @selected_departure_airport = params[:departure_airport_id]
      @selected_arrival_airport = params[:arrival_airport_id]
      @flights = Flight.search(flight_search_params)
    else
      # placeholder airport codes with connecting flights
      @selected_departure_airport = '3706'
      @selected_arrival_airport = '3779'
      @flights = []
    end
  end

  private

  def flight_search_params
    { departure_airport: params[:departure_airport_id],
      arrival_airport: params[:arrival_airport_id],
      no_of_passengers: params[:no_of_passengers],
      date: Date.parse(params[:date]) }
  end
end
