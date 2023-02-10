class AddRegionToAirports < ActiveRecord::Migration[7.0]
  def change
    add_column :airports, :region, :text
  end
end
