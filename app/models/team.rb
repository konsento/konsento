class Team < ActiveRecord::Base
  has_many :subscriptions, as: :subscriptable
  has_many :groups
end
