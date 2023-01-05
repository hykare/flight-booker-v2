class CreateAirports < ActiveRecord::Migration[7.0]
  def change
    create_table :airports do |t|
      t.string :code, index: { unique: true }
      t.string :name
      t.string :country_code
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
