class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :children, inverse_of: :parent, class_name: 'Topic', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Topic', foreign_key: :parent_id
  has_many :proposals
  has_and_belongs_to_many :tags
  has_many :comments, as: :commentable
end
