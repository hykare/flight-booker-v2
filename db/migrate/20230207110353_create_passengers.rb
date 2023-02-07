class CreatePassengers < ActiveRecord::Migration[7.0]
  def change
    create_table :passengers do |t|
      t.text :first_name
      t.text :last_name
      t.text :email
      t.text :phone_no
      t.references :booking

      t.timestamps
    end
  end
end
