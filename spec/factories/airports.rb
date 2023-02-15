FactoryBot.define do
  factory :airport do
    code { Faker::Alphanumeric.alpha(number: 3).upcase }
    name { Faker::Travel::Airport.name(size: 'large', region: 'european_union') }
    region { 'EU' }
    country_code { Faker::Address.country_code }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    factory :airport_with_departing_flight do
      after(:create) do |airport|
        arrival_airport = create(:airport)
        create(:flight, departure_airport: airport, arrival_airport:)
      end
    end
  end
end
