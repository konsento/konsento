class UserObserver < ActiveRecord::Observer
  def after_create(user)
    #Check if user has notifications to be created
    team_invitations = TeamInvitation.where(email: user.email)
    team_invitations.each do |team_invitation|
        Notification.notify(team_invitation)
    end
  end
end
