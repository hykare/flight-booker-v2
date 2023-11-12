class Offer
  attr_accessor :id,
                :itineraries,
                :price

  def initialize(params)
    @id = params[:id]
    @itineraries = params[:itineraries]
    @price = params[:price]
  end
  
  def self.parse(offer)
    id = offer['id']
    itineraries = offer['itineraries']
    price = offer['price']
    
    itineraries.map! { |itinerary| Itinerary.parse(itinerary) }
    price = Price.parse(price)

    Offer.new(
      id: id,
      itineraries: itineraries,
      price: price
    )
  end

end