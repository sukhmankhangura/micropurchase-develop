class Admin::ProposalsController < Admin::BaseController
  def create
    flash[:error] = I18n.t('controllers.admin.proposals.create.failure')

    redirect_to admin_auction_path(auction)
  end

  private

  def auction
    @_auction ||= Auction.find(params[:auction_id])
  end
end
