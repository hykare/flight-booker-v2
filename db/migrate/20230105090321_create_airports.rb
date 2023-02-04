class CreateAirports < ActiveRecord::Migration[7.0]
  def change
    create_table :airports do |t|
      t.text :code, index: { unique: true }
      t.text :name
      t.text :country_code
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
