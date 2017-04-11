class Comment < ApplicationRecord
  belongs_to :user
  has_many :children, inverse_of: :parent, class_name: 'Comment', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Comment', foreign_key: :parent_id
  belongs_to :commentable, polymorphic: true, touch: true

  validates :user, presence: true
  validates :content, presence: true
  validates :commentable, presence: true

  after_create { |comment| Notification.notify(comment) }
end
