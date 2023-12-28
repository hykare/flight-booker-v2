# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_28_193848) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airports", force: :cascade do |t|
    t.text "code"
    t.text "name"
    t.text "country_code"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "region"
    t.index ["code"], name: "index_airports_on_code", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "flight_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "flight_offer_id"
    t.boolean "confirmed"
    t.index ["flight_id"], name: "index_bookings_on_flight_id"
    t.index ["flight_offer_id"], name: "index_bookings_on_flight_offer_id"
  end

  create_table "flight_offers", force: :cascade do |t|
    t.text "search_id"
    t.integer "offer_id"
    t.json "offer", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["search_id", "offer_id"], name: "index_flight_offers_on_search_id_and_offer_id", unique: true
  end

  create_table "passengers", force: :cascade do |t|
    t.text "first_name"
    t.text "last_name"
    t.text "email"
    t.text "phone_no"
    t.bigint "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_passengers_on_booking_id"
  end

  add_foreign_key "bookings", "flight_offers"
end
