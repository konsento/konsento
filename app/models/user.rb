class User < ActiveRecord::Base
  include Clearance::User
  attr_accessor :empty_requirement_values

  has_many :subscriptions
  has_many :votes
  has_many :comments
  has_many :proposals
  has_many :requirement_values
  has_many :join_requirements, through: :requirement_values
  has_many :topics
  has_many :invitations, inverse_of: :user, dependent: :destroy
  has_many :groups, through: :subscriptions, source: :subscriptable, source_type: 'Group'
  has_many :teams, through: :subscriptions, source: :subscriptable, source_type: 'Team'

  before_create { |record| record.available_invitations = 10 }

  validates :password, confirmation: true

  def requirement_values_attributes=(attributes)
  end

  def empty_requirement_values_for(group)
    empty_join_requirements = group.join_requirements - self.join_requirements

    empty_join_requirements.map do |jr|
      jr.requirement_values.build(user: self)
    end
  end
end
