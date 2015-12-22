class JoinRequirement < ActiveRecord::Base
  has_many :requirement_values
  has_many :users, through: :requirement_values
  has_and_belongs_to_many :groups
end
