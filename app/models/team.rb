class Team < ActiveRecord::Base
  has_many :subscriptions, as: :subscriptable
  has_many :groups
  has_many :requirements, as: :requirable
  has_many :join_requirements, through: :requirements
end
