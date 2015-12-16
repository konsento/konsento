class User < ActiveRecord::Base
  include Clearance::User

  has_many :subscriptions
  has_many :votes
  has_many :comments
  has_many :proposals
  has_many :requirement_values
  has_many :topics
  has_many :invitations

  validates :password, confirmation: true
end
