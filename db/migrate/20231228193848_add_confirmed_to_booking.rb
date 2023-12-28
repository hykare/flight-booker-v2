class AddConfirmedToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :confirmed, :boolean
  end
end
