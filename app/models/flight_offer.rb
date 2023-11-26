# my model for view template
class FlightOffer
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
