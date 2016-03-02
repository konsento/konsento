FactoryGirl.define do
  factory :invitation do
    user
    email 'paulo@email.com'
    token 'sampletoken123456'
    registered false
  end
end
