class NotificationsController < ApplicationController
  before_action :require_login
  # GET /notifications
  def index
    @notifications = current_user.notifications
  end

  private
    # Only allow a trusted parameter "white list" through.
    def notification_params
      params[:notification]
    end
end
