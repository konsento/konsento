class Topic < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search,
                  ignoring: :accents,
                  against: [:title], 
                  associated_against: {proposals: [:content]}

  acts_as_taggable

  belongs_to :user
  belongs_to :group
  has_many :children, inverse_of: :parent, class_name: 'Topic', foreign_key: :parent_id
  belongs_to :parent, inverse_of: :children, class_name: 'Topic', foreign_key: :parent_id
  has_many :proposals, dependent: :destroy
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :proposals, reject_if: :all_blank

  validates :title, :proposals, presence: true
  validate :user_is_subscribed_to_group

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

  private

  def user_is_subscribed_to_group
    unless user.groups.include?(group)
      errors.add(:base, 'User must be subscribed to group')
    end
  end
end
