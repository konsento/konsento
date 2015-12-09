class Proposal < ActiveRecord::Base
  belongs_to :user
  has_many :children, inverse_of: :parent, class_name: 'Proposal', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Proposal', foreign_key: :parent_id
  belongs_to :topic
  has_many :votes
  has_many :references
  has_many :comments, as: :commentable
end
