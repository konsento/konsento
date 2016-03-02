class RequirementValue < ActiveRecord::Base
  belongs_to :user
  belongs_to :join_requirement

  validates :user, presence: true
  validates :join_requirement, presence: true
  validates :value, presence: true
end
