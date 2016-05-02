FactoryGirl.define do
  factory :section do
    index 0
    before :create do |section|
      user = build :user
      location = build :location
      topic = build :topic, user: user, location: location
      subscription = build :subscription, user: user, subscriptable: location
      section.topic = topic
    end
  end

end
