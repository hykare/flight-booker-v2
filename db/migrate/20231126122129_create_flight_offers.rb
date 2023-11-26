class CreateFlightOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :flight_offers do |t|
      t.text :search_id
      t.integer :offer_id
      t.json :offer, default: []

      t.timestamps
    end

    add_index :flight_offers, [:search_id, :offer_id], unique: true

  end
end
