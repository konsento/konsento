class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :topic
  has_many :proposals
  has_and_belongs_to_many :tags
  has_many :comments, as: :commentable
end
