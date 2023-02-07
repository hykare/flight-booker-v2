class BookingsController < ApplicationController
  def new
    flight = Flight.find params[:flight]
    @booking = Booking.new flight: flight
    @no_of_passengers = params[:passengers].to_i
    @no_of_passengers.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      puts 'success !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      redirect_to @booking
    else
      print @booking.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find params[:id]
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, :no_of_passengers,
                                    passengers_attributes: %i[first_name last_name email phone_no])
  end
end
