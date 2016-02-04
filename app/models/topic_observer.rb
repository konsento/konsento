class TopicObserver < ActiveRecord::Observer
  def after_create(topic)
    key = 'new_topic'
    data = { 'group_title' => topic.group.title }
    users = topic.group.users.pluck(:id)
    users.delete(topic.user_id)

    users.each do |user_id|
      Notification.create(
        user_id: user_id,
        key: key,
        data: data,
        notifiable: topic
      )
    end
  end
end
