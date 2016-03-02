FactoryGirl.define do
  factory :proposal do
    user
    section factory: :section, strategy: :build
    content 'Content sample'
  end
end
