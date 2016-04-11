class User < ActiveRecord::Base
  include Clearance::User
  attr_accessor :empty_requirement_values

  has_many :authentications, :dependent => :destroy
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

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true, confirmation: true
  validates :available_invitations, numericality: { only_integer: true, allow_blank: true }

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

  def self.create_with_auth_and_hash(authentication, auth_hash)
    create! do |u|
      u.username = User.generate_username_by_name(auth_hash["info"]["name"])
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.password = SecureRandom.hex(32)
      u.authentications << (authentication)
    end
  end

  def self.generate_username_by_name(name)
    username = I18n.transliterate(name).gsub(/[^0-9A-Za-z]/, '')

    loop do
      suffix = rand(1..999).to_s
      if User.where(username: username + suffix).blank?
        username = username + suffix
        break
      end
    end

    username
  end

  def fb_token
    x = self.authentications.where(provider: :facebook).first
    return x.token unless x.nil?
  end

end
