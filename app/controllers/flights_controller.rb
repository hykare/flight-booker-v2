require 'securerandom'

class FlightsController < ApplicationController
  def index
    @airport_options = european_airports
    @selected_departure_airport = choose_selected_departure_airport
    @flights = search_flights
  end

  private

  def search_flights
    if query_submitted?
      @search_id = SecureRandom.uuid
      FlightOfferSearch.search(@search_id, flight_search_params)
    else
      []
    end
  end

  def european_airports
    Airport.european.alphabetical.map do |airport| 
      label = "#{airport.name} (#{airport.code})"
      value = airport.code
      [label, value] 
    end
  end

  def choose_selected_departure_airport
    if query_submitted?
      params[:departure_airport_code]
    else
      nearest_airport&.code || default_airport&.code
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
    { departure_airport_code: params[:departure_airport_code],
      arrival_airport_code: params[:arrival_airport_code],
      no_of_passengers: params[:no_of_passengers],
      date: Date.parse(params[:date]) }
  end
end
