class BookingsController < ApplicationController
  def new
    flight_offer = FlightOffer.find_by(search_id: params[:search_id], offer_id: params[:offer_id])

    @booking = Booking.new flight_offer: flight_offer
    @no_of_passengers = params[:passengers].to_i
    @no_of_passengers.times { @booking.passengers.build }

    offer_model = Offer.parse(flight_offer.offer)
    @flight = FlightOfferViewModel.from_offer(offer_model)
  end

  def create
    offer = FlightOffer.find_by(search_id: booking_params[:search_id], offer_id: booking_params[:offer_id])
    @booking = Booking.new(flight_offer: offer)
    @booking.passengers_attributes = booking_params[:passengers_attributes]

    if @booking.save
      redirect_to @booking
    else
      print @booking.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find params[:id]
    offer_model = Offer.parse(@booking.flight_offer.offer)
    @flight = FlightOfferViewModel.from_offer(offer_model)
  end

  private

  def booking_params
    params.require(:booking).permit(:offer_id, :search_id, :no_of_passengers,
                                    passengers_attributes: %i[first_name last_name email phone_no])
  end
end
