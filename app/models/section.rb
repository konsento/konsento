class Section < ActiveRecord::Base
  belongs_to :topic, inverse_of: :sections, required: true, touch: true
  has_many :proposals, inverse_of: :section, autosave: true, dependent: :destroy
  validates :topic, presence: true
  validates :index, presence: true
  validates :index, numericality: { only_integer: true }

  default_scope { order(index: :asc) }

  def consensus
    total_votes_minimum_percent = topic.group.total_votes_percent
    agree_votes_minimum_percent = topic.group.agree_votes_percent

    proposal = nil
    users_votes_count = proposals.joins(:votes).group('votes.user_id').size.size
    group_subscriptions_count = topic.group.subscriptions.count

    total_votes_percent = (users_votes_count * 100) / group_subscriptions_count

    if total_votes_percent > total_votes_minimum_percent
      proposals_in_consensus = []

      proposals.each do |p|
        agree_votes = p.votes.agree.size
        agree_votes_percent = (agree_votes * 100) / users_votes_count

        if agree_votes_percent > agree_votes_minimum_percent
          proposals_in_consensus << p
        end
      end

      unless proposals_in_consensus.empty?
        proposal = best_consensus_proposal(proposals_in_consensus)
      end
    end

    unless proposal
      proposal = proposals.find_by(parent: nil)
    end

    proposal
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
end
