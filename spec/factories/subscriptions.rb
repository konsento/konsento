FactoryGirl.define do
  factory :subscription do
    user
    role 'default'
    trait :location_subscription do
      association :subscriptable, factory: :location
    end
    trait :team_subscription do
      association :subscriptable, factory: :team
    end
  end

end
