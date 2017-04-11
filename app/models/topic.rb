class Topic < ApplicationRecord
  include PgSearch

  pg_search_scope :search,
                  ignoring: :accents,
                  against: [:title],
                  associated_against: {proposals: [:content]}

  acts_as_taggable

  belongs_to :user
  belongs_to :location
  belongs_to :parent, inverse_of: :children, class_name: 'Topic', foreign_key: :parent_id
  belongs_to :team
  has_many :children, inverse_of: :parent, class_name: 'Topic', foreign_key: :parent_id
  has_many :sections, inverse_of: :topic, autosave: true, dependent: :destroy
  has_many :proposals, through: :sections
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :participants, -> { distinct }, through: :proposals, source: :user

  validate :user_is_subscribed_to_location
  validates :title, presence: true
  validates :location, presence: true

  after_create { |topic| Notification.notify(topic) }

  accepts_nested_attributes_for :proposals, reject_if: :all_blank

  scope :for_user, -> (user = nil) do
    query = joins('LEFT JOIN teams ON teams.id = topics.team_id')
    w = 'team_id IS NULL OR teams.public = TRUE'

    if user
      w << ' OR team_id IN (?)'
      query = query.where(w, user.teams.pluck(:id))
    else
      query = query.where(w)
    end

    query
  end

  scope :recent, -> { order(updated_at: :desc) }

  scope :popular, -> do
    joins(:proposals).group('topics.id').order('COUNT(DISTINCT(proposals.user_id)) DESC')
  end

  scope :controversial, -> { joins(:proposals).group('topics.id').order('COUNT(proposals.id) DESC') }

  private
    def user_is_subscribed_to_location
      unless user.locations.include?(location)
        errors.add(:base, 'User must be subscribed to location')
      end
    end
end
