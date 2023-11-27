require 'securerandom'

class FlightOfferSearch

  def self.search(search_id, search_params)
    flight_offers = AmadeusApi.get_offers(search_params)
    save_search(search_id, flight_offers)

    flights = flight_offers.map do |offer|
      offer = Offer.parse(offer)
      # offer_to_template_model(offer)
      FlightOfferViewModel.from_offer(offer)
    end
    
    flights.sort_by(&:start)
  end

  # object to template model
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

  # todo delete? object fields are accessed in template, looks bad with raw hash
  def self.json_offer_to_template_model(offer)
    itineraries = offer['itineraries']
    segments = itineraries.first['segments']

    departure_time = Time.parse(segments.first['departure']['at'])
    arrival_time = Time.parse(segments.last['arrival']['at'])
    price = offer['price']['grand_total']
    offer_id = offer['id']

    # intermediate stops are ignored here
    departure_airport = Airport.find_by(code: segments.first['departure']['iata_code'])
    arrival_airport = Airport.find_by(code: segments.last['arrival']['iata_code'])
    number_of_stops = segments.length - 1

    FlightOfferViewModel.new(
      departure_airport: departure_airport,
      arrival_airport: arrival_airport,
      start: departure_time,
      duration: arrival_time - departure_time,
      price: price,
      number_of_stops: number_of_stops,
      id: offer_id
    )
  end

  def self.save_search(search_id, offer_results)
    flight_offers_json = offer_results.map do |offer|
      { search_id: search_id,
        offer_id: offer['id'],
        offer: offer
      }
    end
    FlightOffer.create(flight_offers_json)
  end

end
