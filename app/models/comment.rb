class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  belongs_to :commentable, polymorphic: true
end
