class Group < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search,
                  ignoring: :accents,
                  against: [:title, :description]

  has_many :children, inverse_of: :parent, class_name: 'Group', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Group', foreign_key: :parent_id
  has_many :subscriptions
  has_many :topics
  has_and_belongs_to_many :join_requirements

  def parents
    ancestry = [parent]

    while ancestry.last.try(:parent) && ancestry.size <= 10
      ancestry << ancestry.last.parent
    end

    ancestry.compact
  end

  def is_user_subscribed?(user)
    self.subscriptions.where(user: user).exists?
  end
end
