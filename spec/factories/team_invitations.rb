FactoryGirl.define do
  factory :team_invitation do
    team
    email 'eduardo@email.com'
    token 'sampletoken123456'
    accepted false
  end

end
