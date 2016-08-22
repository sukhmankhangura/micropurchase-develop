class EligibilityFactory
  attr_reader :start_price_threshold

  def initialize(auction)
    @start_price_threshold = AuctionThreshold.new(auction)
  end

  def create
    FullEligibility.new
  end
end
