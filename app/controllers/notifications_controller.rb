class NotificationsController < ApplicationController
  before_action :require_login
  # GET /notifications
  def index
    notifications = current_user.notifications.order(id: :desc)
    @notifications = notifications.map do |n|
      if n.read
        {notification: n, read_was: true}
      else
        n.update(read: true)
        {notification: n, read_was: false}
      end
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def notification_params
      params[:notification]
    end
end
