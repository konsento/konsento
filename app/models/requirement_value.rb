class RequirementValue < ActiveRecord::Base
  belongs_to :user
  belongs_to :join_requirement
end
