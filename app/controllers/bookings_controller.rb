class BookingsController < ApplicationController

  def new
    flight = Flight.find params[:flight]
    @booking = Booking.new flight: flight
    @no_of_passengers = params[:passengers]
    # params should have chosen flight, number of passengers
  end

end
