FactoryGirl.define do
  factory :comment do
    user
    content 'Comment content'
    trait :proposal_comment do
      association :commentable, factory: :proposal, strategy: :build
    end
    trait :topic_comment do
      association :commentable, factory: :location, strategy: :build
    end
  end
end
