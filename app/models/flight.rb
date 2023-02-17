class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: 'Airport'
  belongs_to :arrival_airport, class_name: 'Airport'
  has_many :bookings

  def self.search(search_params)
    Flight.where(arrival_airport: search_params[:arrival_airport],
                 departure_airport: search_params[:departure_airport])
    #  start: search_params[:date])
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
    hours = duration / 3600
    minutes = (duration % 3600) / 60
    if minutes.zero?
      "#{hours} hr"
    else
      "#{hours} hr #{minutes} min"
    end
  end

  def route_codes
    "#{departure_airport.code} - #{arrival_airport.code}"
  end

  def price_guesstimate_eur
    '1 234,67'
  end

  def stops_number
    'nonstop'
  end
end
