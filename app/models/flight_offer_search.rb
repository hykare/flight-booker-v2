
class FlightOfferSearch

  def self.search(search_params)
    flight_offers = AmadeusApi.get_offers(search_params)

    flights = flight_offers.map do |offer|
      check_multiple_itineraries(offer) # debug - are there ever multiple?
      offer_to_template_model(offer)
    end

    flights.sort_by(&:start)
  end

  def self.offer_to_template_model(offer)
    itineraries = offer.itineraries
    segments = itineraries.first.segments

    departure_time = segments.first.departure.at
    arrival_time = segments.last.arrival.at
    price = offer.price.grand_total

    # intermediate stops are ignored here
    departure_airport = Airport.find_by(code: segments.first.departure.iata_code)
    arrival_airport = Airport.find_by(code: segments.last.arrival.iata_code)
    number_of_stops = segments.length - 1

    FlightOfferViewModel.new(
      departure_airport: departure_airport,
      arrival_airport: arrival_airport,
      start: departure_time,
      duration: arrival_time - departure_time,
      price: price,
      number_of_stops: number_of_stops,
      id: offer.id
    )
  end

  def self.check_multiple_itineraries(offer)
    # when does this happen?
    if offer.itineraries.length > 1
      puts "MULTIPLE ITINERARIES: #{itineraries_count} Offer id: #{offer.id}"
    end
  end
end
