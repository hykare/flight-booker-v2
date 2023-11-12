class FlightEndPoint
  attr_accessor :iata_code,
                :terminal,
                :at

  def initialize(params)
    @iata_code = params[:iata_code]
    @terminal = params[:terminal]
    @at = Time.parse(params[:at])
  end

  def self.parse(endpoint)
    FlightEndPoint.new(
      iata_code: endpoint['iataCode'],
      terminal: endpoint['terminal'],
      at: endpoint['at']
    )
  end

  def at_formatted
    # TODO
    at.to_s
  end

end