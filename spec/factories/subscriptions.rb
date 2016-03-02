FactoryGirl.define do
  factory :subscription do
    user
    role 'default'
    trait :group_subscription do
      association :subscriptable, factory: :group
    end
    trait :team_subscription do
      association :subscriptable, factory: :team
    end
  end

end
