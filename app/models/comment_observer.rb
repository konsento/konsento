class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    Notification.notify(comment)
  end
end
