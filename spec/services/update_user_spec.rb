require 'rails_helper'

describe UpdateUser do
  context 'when SAM.gov says the vendor is a small business' do
    it 'sets small_business to true' do
      user = create(:user)
      params = ActionController::Parameters.new(
        id: user.id, user: { duns_number: FakeSamApi::SMALL_BUSINESS_DUNS }
      )

      UpdateUser.new(params, user).save

      Delayed::Worker.new.work_off
      user.reload
    end
  end

  context 'when the params are insufficient' do
    it 'raises some param related error' do
      params = ActionController::Parameters.new(id: user_id)

      expect { UpdateUser.new(params, user).save }
        .to raise_error(ActionController::ParameterMissing)
    end
  end

  context 'when the payment_url is not valid' do
    xit 'raises an error on the save' do
      params = ActionController::Parameters.new(
        id: user_id, user: { payment_url: 'fiff13t913jt10h' }
      )

      updater = UpdateUser.new(params, user)

      expect(updater.save).to be_falsey
      expect(updater.errors).to eq('Payment url is not a valid URL')
    end
  end

  context 'payment_url is updated for winning vendor' do
    context 'payment_url set to valid value' do
      it 'calls AcceptAuction' do
        auction = create(:auction, :with_bidders, status: :accepted)
        winning_bidder = WinningBid.new(auction).find.bidder
        winning_bidder.update(payment_url: '')
        accepter = double(perform: true)
        new_payment_url = "http://example.com/payme"
        allow(AcceptAuction).to receive(:new)
          .with(auction: auction, payment_url: new_payment_url)
          .and_return(accepter)
        params = ActionController::Parameters.new(
          id: winning_bidder.id, user: { payment_url: new_payment_url }
        )

        UpdateUser.new(params, winning_bidder).save

        expect(accepter).to have_received(:perform)
      end
    end
  end

  def user
    @_user ||= create(:user)
  end

  def user_id
    user.id
  end
end
