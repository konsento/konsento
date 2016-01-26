class Requirement < ActiveRecord::Base
  belongs_to :requirable, polymorphic: true, touch: true
  belongs_to :join_requirement
end
