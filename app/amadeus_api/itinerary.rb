class Itinerary
  attr_accessor :duration,
                :segments

  def initialize(params)
    @duration = ActiveSupport::Duration.parse(params[:duration])
    @segments = params[:segments]
  end
  
  def self.parse(itinerary)
    duration = itinerary['duration']
    segments = itinerary['segments']

    segments.map! { |segment| Segment.parse(segment) }

    Itinerary.new(
      duration: duration,
      segments: segments
    )
  end
end
