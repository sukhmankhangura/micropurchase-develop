class UserQuery
  def initialize(relation = User.all)
    @relation = relation.extending(Scopes)
  end

  [
    :with_bids
  ].each do |key|
    define_method key do
      @relation.send(key)
    end
  end

  module Scopes
    def with_bids
      includes(:bids).where.not(bids: { bidder_id: nil })
    end
  end
end
