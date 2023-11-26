class AddFlightOfferToBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :flight_offer, foreign_key: true
  end
end
