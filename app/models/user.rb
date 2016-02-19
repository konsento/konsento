class User < ActiveRecord::Base
  include Clearance::User
  attr_accessor :empty_requirement_values

  has_many :subscriptions
  has_many :votes
  has_many :comments
  has_many :notifications
  has_many :proposals
  has_many :requirement_values
  has_many :join_requirements, through: :requirement_values
  has_many :topics
  has_many :invitations, inverse_of: :user, dependent: :destroy
  has_many :groups, through: :subscriptions, source: :subscriptable, source_type: 'Group'
  has_many :teams, through: :subscriptions, source: :subscriptable, source_type: 'Team'

  before_create { |record| record.available_invitations = 10 }

  validates :password, confirmation: true

  def is_team_admin?(team)
    subscription = Subscription.find_by(subscriptable: team, user: self)
    subscription.role == 'admin'
  end

  def requirement_values_attributes=(attributes)
  end

  def empty_requirement_values_for(requirable)
    empty_join_requirements = requirable.join_requirements - self.join_requirements

    empty_join_requirements.map do |jr|
      jr.requirement_values.build(user: self)
    end
  end

  def accessible_teams
    Team.accessible_for(self)
  end
end
