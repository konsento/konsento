class Group < ActiveRecord::Base
    belongs_to :group
    has_many :subscriptions
    has_many :topics
    has_and_belongs_to_many :join_requirements
end
