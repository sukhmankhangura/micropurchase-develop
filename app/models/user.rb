class User < ActiveRecord::Base
  has_many :bids, foreign_key: 'bidder_id'

  validates :email, presence: true, email: true
  validates :github_id, presence: true
  validates :github_login, presence: true

  def decorate
    if Admins.verify?(github_id)
      AdminUserPresenter.new(self)
    else
      UserPresenter.new(self)
    end
  end
end
