FactoryGirl.define do
  factory :section do
    index 0
    before :create do |section|
      user = build :user
      group = build :group
      topic = build :topic, user: user, group: group
      subscription = build :subscription, user: user, subscriptable: group
      section.topic = topic
    end
  end

end
