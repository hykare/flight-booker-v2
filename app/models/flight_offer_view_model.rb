# my model for view template
class FlightOfferViewModel
  attr_accessor :departure_airport,
                :arrival_airport,
                :start,
                :duration,
                :price,
                :number_of_stops,
                :id

  def initialize(params)
    @departure_airport = params[:departure_airport]
    @arrival_airport = params[:arrival_airport]
    @start = params[:start]
    @duration = params[:duration]
    @price = params[:price]
    @number_of_stops = params[:number_of_stops]
    @id = params[:id]
  end

  def self.from_offer(offer)
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

  def time_formatted
    from = start.strftime('%l:%M %p')
    to = (start + duration).strftime('%l:%M %p')
    "#{from} - #{to}"
  end

  def departure_time
    start.strftime('%l:%M %p')
  end

  def arrival_time
    (start + duration).strftime('%l:%M %p')
  end

  def date_formatted
    start.strftime('%d %b %Y')
  end

  def duration_formatted
    hours = (duration / 3600).to_i
    minutes = ((duration % 3600) / 60).to_i
    if minutes.zero?
      "#{hours} hr"
    else
      "#{hours} hr #{minutes} min"
    end
  end

  def route_codes
    "#{departure_airport.code} - #{arrival_airport.code}"
  end

  def stops_number
    if number_of_stops.zero? 
      'nonstop'
    else
      "#{number_of_stops} stops"
    end
  end

  def price_eur
    "#{price} EUR"
  end
end
