class Requirement < ApplicationRecord
  belongs_to :requirable, polymorphic: true, touch: true
  belongs_to :join_requirement
end
