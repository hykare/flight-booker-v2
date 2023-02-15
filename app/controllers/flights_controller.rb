class FlightsController < ApplicationController
  def index
    prepare_search_form_options
    choose_selected_departure_airport
    search_flights
  end

  private

  def prepare_search_form_options
    prepare_airport_options
    @dates = dates_with_flights
  end

  def prepare_airport_options
    @departure_airport_options = Airport.with_scheduled_departures.alphabetical.map do |a|
      ["#{a.name} (#{a.code})", a.id]
    end
    @arrival_airport_options = Airport.with_scheduled_arrivals.alphabetical.map { |a| ["#{a.name} (#{a.code})", a.id] }
  end

  def dates_with_flights
    Flight.pluck(:start).map { |date| date.strftime('%d %b %Y') }.uniq
  end

  def search_flights
    if query_submitted?
      @flights = Flight.search(flight_search_params)
    else
      @flights = []
    end
  end

  def choose_selected_departure_airport
    if query_submitted?
      @selected_departure_airport = params[:departure_airport_id]
    else
      @selected_departure_airport = nearest_airport&.id || default_airport&.id
    end
  end

  def nearest_airport
    Airport.near(user_location).first
  end

  def default_airport
    Airport.find_by(code: 'LHR')
  end

  def user_location
    # empty array if location invalid (eg localhost) on the first request
    # empty string on subsequent requests
    # what happens if blocked by browser?
    cookies.fetch(:location, request.location.coordinates)
  end

  def query_submitted?
    params[:commit] ? true : false
  end

  def flight_search_params
    { departure_airport: params[:departure_airport_id],
      arrival_airport: params[:arrival_airport_id],
      no_of_passengers: params[:no_of_passengers],
      date: Date.parse(params[:date]) }
  end
end
