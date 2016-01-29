class Topic < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search,
                  ignoring: :accents,
                  against: [:title],
                  associated_against: {proposals: [:content]}

  acts_as_taggable

  belongs_to :user
  belongs_to :group
  has_many :children, inverse_of: :parent, class_name: 'Topic', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Topic', foreign_key: :parent_id
  belongs_to :team
  has_many :proposals, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :participants, -> { uniq }, through: :proposals, source: :user

  accepts_nested_attributes_for :proposals, reject_if: :all_blank

  scope :recent, -> { order(updated_at: :desc) }

  scope :popular, -> do
    joins(:proposals).group('topics.id').order('COUNT(DISTINCT(proposals.user_id)) DESC')
  end

  scope :controversial, -> { joins(:proposals).group('topics.id').order('COUNT(proposals.id) DESC') }

  validates :title, :proposals, presence: true
  validate :user_is_subscribed_to_group

  def proposal_consensus(proposal_index)
    total_votes_minimum_percent = self.group.total_votes_percent
    agree_votes_minimum_percent = self.group.agree_votes_percent

    proposal = nil
    proposals = self.proposals.where(proposal_index: proposal_index)
    users_votes_count = proposals.joins(:votes).group('votes.user_id').size.size
    group_subscriptions_count = self.group.subscriptions.count

    total_votes_percent = (users_votes_count * 100) / group_subscriptions_count

    if total_votes_percent >= total_votes_minimum_percent
      proposals_in_consensus = []
      proposals.each do |p|
        agree_votes = p.votes.agree.size
        agree_votes_percent = (agree_votes * 100) / users_votes_count
        if agree_votes_percent >= agree_votes_minimum_percent
          proposals_in_consensus << p
        end
      end
      unless proposals_in_consensus.empty?
        proposal =  best_consensus_proposal(proposals_in_consensus)
      end
    end
    proposal
  end

  def proposals_count
    self.proposals.where(parent_id: nil).count
  end

  private
  # Selects most agreed proposal, searches for proposals with the
  # same positive votes number and uses negative votes as tiebreaker
  def best_consensus_proposal(proposals_in_consensus)
    last_consensus_proposal = proposals_in_consensus.max_by do |p|
      p.votes.agree.size
    end
    consensus_proposals = proposals_in_consensus.select do |p|
      p.votes.agree.size == last_consensus_proposal.votes.agree.size
    end
    consensus_proposals.min_by { |p| p.votes.disagree.size}
  end

  def user_is_subscribed_to_group
    unless user.groups.include?(group)
      errors.add(:base, 'User must be subscribed to group')
    end
  end
end
