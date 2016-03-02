FactoryGirl.define do
  factory :user do
    username 'joao'
    email 'joao@email.com'
    password '123456'
    available_invitations 10
  end

end
