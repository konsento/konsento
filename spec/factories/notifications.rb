FactoryGirl.define do
  factory :notification do
    user
    key 'I18n_key'
    data '{}'
    read true
    before :create do |notification|
      user = build :user
      topic = build :topic, user: user
      notification.notifiable = topic
    end
  end
end
