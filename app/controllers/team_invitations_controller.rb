class TeamInvitationsController < ApplicationController

  def create
    team = Team.find(team_invitation_params[:team_id])
    TeamInvitation.invite_emails(team_invitation_params[:email], team)
    redirect_to invitations_team_path(team)
  end

  private

  def team_invitation_params
    params.require(:team_invitation).permit(:team_id, :email)
  end
end
