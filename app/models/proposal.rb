class Proposal < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search,
                  ignoring: :accents,
                  against: [:content]

  belongs_to :user
  belongs_to :parent, inverse_of: :children, class_name: 'Proposal', foreign_key: :parent_id
  belongs_to :section, inverse_of: :proposals, required: true, touch: true
  has_many :children, inverse_of: :parent, class_name: 'Proposal', foreign_key: :parent_id
  has_many :votes
  has_many :references
  has_many :comments, as: :commentable

  delegate :topic, to: :section

  scope :recent, -> { order(updated_at: :desc) }

  scope :popular, -> do
    joins('LEFT JOIN votes v ON v.proposal_id = proposals.id').
    group('proposals.id').
    order('COUNT(v.id) DESC')
  end

  scope :controversial, -> do
    joins('LEFT JOIN votes agree ON (proposals.id = agree.proposal_id AND agree.opinion = 1)').
    joins('LEFT JOIN votes disagree ON (proposals.id = disagree.proposal_id AND disagree.opinion = -1)').
    group('proposals.id').
    order('(LEAST(@SUM(agree.opinion), @SUM(disagree.opinion))/GREATEST(@SUM(agree.opinion), @SUM(disagree.opinion))) ASC')
  end

  validates :content, presence: true

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
    if vote.persisted? && vote.opinion == opinion
      vote.destroy
    else
      vote.update_attributes(opinion: opinion)
    end
    vote
  end
end
