class TopicObserver < ActiveRecord::Observer
  def after_create(topic)
    Notification.notify(topic)
  end
end
