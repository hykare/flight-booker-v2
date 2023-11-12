class AmadeusApi

  @client = Amadeus::Client.new(
    client_id: 'TBiEQaDREkC9ZU52widMJvGRQi0dWGyU',
    # TODO: move secret to env variable
    client_secret: '86WSTTVeVA1O4ME6'
  )

  class << self
    attr_reader :client
  end

  def self.get_offers(search_params) 
    departure_airport_code = search_params[:departure_airport_code]
    arrival_airport_code = search_params[:arrival_airport_code]
    date = search_params[:date]

    amadeus_response = client.shopping.flight_offers_search.get(originLocationCode: departure_airport_code,
                                                                 destinationLocationCode: arrival_airport_code,
                                                                 departureDate: date,
                                                                 adults: 1,
                                                                 max: 15).result

    # debug
    puts amadeus_response if amadeus_response['meta']['count'].to_i.zero?

    flight_offers = amadeus_response['data']
    return [] if flight_offers.nil?

    flight_offers.map! do |offer|
      Offer.parse(offer)
    end
  end
end
