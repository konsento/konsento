class Proposal < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search,
                  ignoring: :accents,
                  against: [:content]

  belongs_to :user
  has_many :children, inverse_of: :parent, class_name: 'Proposal', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Proposal', foreign_key: :parent_id
  belongs_to :topic, touch: true
  has_many :votes
  has_many :references
  has_many :comments, as: :commentable

  scope :recent, -> (index = nil) do
    q = order(updated_at: :desc)
    q = q.where(proposal_index: index) if index
    q
  end

  scope :popular, -> (index = nil) do
    q = joins(:votes).group('proposals.id').order('COUNT(votes.id) DESC')
    q = where(proposal_index: index) if index
    q
  end

  scope :controversial, -> (index = nil) do
    q = joins('LEFT JOIN votes agree ON (proposals.id = agree.proposal_id AND agree.opinion = 1)').
        joins('LEFT JOIN votes disagree ON (proposals.id = disagree.proposal_id AND disagree.opinion = -1)').
        group('proposals.id').
        order('(LEAST(@SUM(agree.opinion), @SUM(disagree.opinion))/GREATEST(@SUM(agree.opinion), @SUM(disagree.opinion))) ASC')
    q = q.where(proposal_index: index) if index
    q
  end

  validates :content, presence: true

  def popular
    Proposal.where(
      topic: self.topic,
      proposal_index: self.proposal_index
    ).where.not(id: self.id)
  end

  def controversial
    Proposal.where(
      topic: self.topic,
      proposal_index: self.proposal_index
    ).where.not(id: self.id)
  end

  def recent
    Proposal.where(
      topic: self.topic,
      proposal_index: self.proposal_index
    ).where.not(id: self.id)
  end

  def vote_agree(user)
    self.vote(user, 1)
  end

  def vote_abstain(user)
    self.vote(user, 0)
  end

  def vote_disagree(user)
    self.vote(user, -1)
  end

  def vote_for_user(user)
    self.votes.find_or_initialize_by(user: user)
  end

  def vote(user, opinion)
    vote = self.votes.find_or_initialize_by(user: user)
    vote.update_attributes(opinion: opinion)
    vote
  end
end
