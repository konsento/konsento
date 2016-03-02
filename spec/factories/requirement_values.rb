FactoryGirl.define do
  factory :requirement_value do
    user
    join_requirement
    value 'Lorem ipsum'
  end
end
