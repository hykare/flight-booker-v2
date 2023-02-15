require 'rails_helper'

RSpec.describe 'searching for a flight', type: :system do
  let!(:departure_airport) { create(:airport) }
  let!(:arrival_airport) { create(:airport) }
  let!(:flight) do
    create(:flight, departure_airport_id: departure_airport.id, arrival_airport_id: arrival_airport.id)
  end

  context 'before submitting search criteria' do
    before do
      # create(:airport_with_departing_flight, code: 'LHR')
      # visit flights_path
    end

    it 'shows popular connections'
  end

  context 'after submitting search criteria' do
    before do
      visit flights_path
      select departure_airport.name, from: 'departure airport'
      select arrival_airport.name, from: 'arrival airport'
      click_on 'search flights'
    end

    it 'shows matching flights' do
      expect(page).to have_field("flight_#{flight.id}")
    end
  end
end
