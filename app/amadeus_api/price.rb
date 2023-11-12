class Price
  attr_accessor :currency,
                :grand_total

  def initialize(params)
    @currency = params[:currency]
    @grand_total = params[:grand_total]
  end
  
  def self.parse(price)
    Price.new(
      currency: price['currency'],
      grand_total: price['grandTotal']
    )
  end
end
