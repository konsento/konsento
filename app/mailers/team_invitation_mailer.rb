class TeamInvitationMailer < ApplicationMailer
  def invite(team_invitation)
    @team_invitation = team_invitation
    mail(to: @team_invitation.email, subject: "Convite para participar do time '#{@team_invitation.team.title}' no Konsento!")
  end
end
