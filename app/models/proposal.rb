class Proposal < ActiveRecord::Base
  belongs_to :user
  has_many :children, inverse_of: :parent, class_name: 'Proposal', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Proposal', foreign_key: :parent_id
  belongs_to :topic
  has_many :votes
  has_many :references
  has_many :comments, as: :commentable

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
