FactoryGirl.define do
  factory :vote do
    user
    proposal
    opinion 0
  end
end
