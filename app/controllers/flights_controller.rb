class FlightsController < ApplicationController
  def index
    @airport_options = Airport.all.map { |a| [a.name, a.id] }
    @dates = Flight.pluck(:start).map { |date| date.strftime("%d %b %Y") }.uniq
  end
end
