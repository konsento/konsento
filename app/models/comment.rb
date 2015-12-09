class Comment < ActiveRecord::Base
  belongs_to :user
  has_many :children, inverse_of: :parent, class_name: 'Comment', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Comment', foreign_key: :parent_id
  belongs_to :commentable, polymorphic: true
end
