class Auction < ActiveRecord::Base
  include AuctionScopes

  attr_accessor :due_in_days

  belongs_to :user
  belongs_to :customer
  has_many :bids
  has_many :bidders, through: :bids
  has_and_belongs_to_many :skills

  enum status: {
    not_applicable: 0,
    pending_acceptance: 3,
    accepted: 1,
    rejected: 2
  }

  enum published: { unpublished: 0, published: 1 }
  enum type: { sealed_bid: 0, reverse: 1 }

  # Disable STI
  self.inheritance_column = :__disabled

  validates :delivery_due_at, presence: true, if: :published?
  validates :description, presence: true, if: :published?
  validates :ended_at, presence: true
  validates :start_price, presence: true
  validates :started_at, presence: true
  validates :summary, presence: true, if: :published?
  validates :title, presence: true
  validates :user, presence: true
  validates :billable_to, presence: true

  def sorted_skill_names
    skills.order(name: :asc).map(&:name)
  end

  def lowest_bid
    lowest_bids.first
  end

  def lowest_bids
    bids.select { |b| b.amount == lowest_amount }.sort_by(&:created_at)
  end

  private

  def lowest_amount
    bids.sort_by(&:amount).first.try(:amount)
  end
end
