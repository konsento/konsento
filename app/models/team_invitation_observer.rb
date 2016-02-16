class TeamInvitationObserver < ActiveRecord::Observer
  def after_create(team_invitation)
    Notification.notify(team_invitation)
  end
end
