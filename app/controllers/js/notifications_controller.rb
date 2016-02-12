class Js::NotificationsController < ApplicationController
  respond_to :js

  def preview
    @notifications = current_user.notifications.order(id: :desc).first(4)
    @notifications.map { |n| n.update(read: true) }
    @unread_notifications_count = current_user.notifications.unread.size
  end
end
