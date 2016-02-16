class Js::NotificationsController < ApplicationController
  respond_to :js

  def preview
    notifications = current_user.notifications.order(id: :desc).first(4)
    @notifications = notifications.map do |n|
      if n.read
        {notification: n, read_was: true}
      else
        n.update(read: true)
        {notification: n, read_was: false}
      end
    end

    @unread_notifications_count = current_user.notifications.unread.size
  end
end
