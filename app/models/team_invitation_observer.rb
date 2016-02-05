class TeamInvitationObserver < ActiveRecord::Observer
  def after_create(team_invitation)
    key = 'team_invitation'
    data = { 'team_title' => team_invitation.team.title }
    user = User.find_by(email: team_invitation.email)

    Notification.create(
      user_id: user.id,
      key: key,
      data: data,
      notifiable: team_invitation
    )
  end
end
