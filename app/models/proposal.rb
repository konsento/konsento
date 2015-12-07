class Proposal < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposal
  belongs_to :topic
  has_many :votes
  has_many :references
  has_many :comments, as: :commentable
end
