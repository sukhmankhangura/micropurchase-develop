class AuctionThreshold
  MICROPURCHASE = 5000
  SAT = 150000

  def initialize(auction)
    @auction = auction
  end

  private

  attr_reader :auction
end
