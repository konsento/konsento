FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "joao#{n}" }
    sequence(:email) { |n| "joao#{n}@email.com" }
    password '123456'
    available_invitations 10
  end

end
