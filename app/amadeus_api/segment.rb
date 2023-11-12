class Segment
  attr_accessor :departure,
                :arrival,
                :duration

  def initialize(params)
    @departure = params[:departure]
    @arrival = params[:arrival]
    @duration = ActiveSupport::Duration.parse(params[:duration])
  end

  def self.parse(segment)
    departure = FlightEndPoint.parse(segment['departure'])
    arrival = FlightEndPoint.parse(segment['arrival'])

    Segment.new(
      departure: departure,
      arrival: arrival,
      duration: segment['duration']
    )
  end

  def duration_formatted
    # TODO
    duration.to_s
  end

end