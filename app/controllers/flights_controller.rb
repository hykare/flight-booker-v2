class FlightsController < ApplicationController
  def index
    @airport_options = Airport.all.map { |a| [a.name, a.id] }
  end
end
