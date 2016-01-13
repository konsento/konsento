class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :children, inverse_of: :parent, class_name: 'Topic', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Topic', foreign_key: :parent_id
  has_many :proposals
  has_and_belongs_to_many :tags
  has_many :comments, as: :commentable

  def consensus
    proposals = self.proposals.includes(:votes).first(3)
  end

  def popular
    self.proposals.last(3)
  end

  def top
    self.proposals.last(3)
  end

  def rising
    self.proposals.last(3)
  end
end
