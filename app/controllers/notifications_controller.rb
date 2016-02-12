class NotificationsController < ApplicationController
  before_action :require_login
  # GET /notifications
  def index
    @notifications = current_user.notifications.order(id: :desc)
    @notifications.unread.update_all(:read => true)
  end

  private
    # Only allow a trusted parameter "white list" through.
    def notification_params
      params[:notification]
    end
end
