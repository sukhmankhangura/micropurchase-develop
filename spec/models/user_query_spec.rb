require 'rails_helper'

describe UserQuery do
  describe '#with_bids' do
    it 'returns users with bids' do
      _user_without_bids = create(:user)
      user_with_bid = create(:user, :with_bid)

      expect(UserQuery.new.with_bids).to match_array([user_with_bid])
    end
  end
end
