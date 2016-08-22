require 'rails_helper'

describe AcceptAuction do
  describe '#perform' do
    context 'auction belongs to a customer' do
      context 'customer has an email' do
        it 'sends an email to the customer' do
          customer = create(:customer, email: 'test@example.com')
          auction = create(:auction, customer: customer)
          mailer_double = double(deliver_later: true)
          allow(AuctionMailer).to receive(:auction_accepted_customer_notification)
            .with(auction: auction)
            .and_return(mailer_double)

          AcceptAuction.new(auction: auction, payment_url: 'example.com').perform

          expect(AuctionMailer).to have_received(:auction_accepted_customer_notification)
            .with(auction: auction)
          expect(mailer_double).to have_received(:deliver_later)
        end
      end

      context 'customer does not have an email' do
        it 'does not send an email to the customer' do
          customer = create(:customer, email: nil)
          auction = create(:auction, :with_bidders, customer: customer)
          allow(AuctionMailer).to receive(:auction_accepted_customer_notification)

          AcceptAuction.new(auction: auction, payment_url: 'example.com').perform

          expect(AuctionMailer).not_to have_received(:auction_accepted_customer_notification)
        end
      end
    end

    context 'auction does not belong to a customer' do
      it 'does not send an email' do
        auction = create(:auction, :with_bidders, customer: nil)
        allow(AuctionMailer).to receive(:auction_accepted_customer_notification)

        AcceptAuction.new(auction: auction, payment_url: 'example.com').perform

        expect(AuctionMailer).not_to have_received(:auction_accepted_customer_notification)
      end
    end

    context 'winning bidder does not have credit card information' do
      it 'sends an email to the winner' do
        auction = create(:auction, :with_bidders)
        mailer_double = double(deliver_later: true)
        allow(AuctionMailer).to receive(:winning_bidder_missing_payment_method)
          .with(auction: auction)
          .and_return(mailer_double)

        AcceptAuction.new(auction: auction, payment_url: '').perform

        expect(AuctionMailer).to have_received(:winning_bidder_missing_payment_method)
          .with(auction: auction)
        expect(mailer_double).to have_received(:deliver_later)
      end
    end
  end
end
