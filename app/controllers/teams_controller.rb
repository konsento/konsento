class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :invitations]

  # GET /teams
  def index
    @teams = Team.all.order(created_at: :asc)
    @pending_team_invitations = TeamInvitation.where(email: current_user.email, accepted: false)
    add_breadcrumb Team.model_name.human(count: 2)
  end

  # GET /teams/1
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
      add_breadcrumb Team.model_name.human(count: 2), teams_path
      add_breadcrumb t '.new_team'
  end

  # GET /teams/1/edit
  def edit
    add_breadcrumb Team.model_name.human(count: 2), teams_path
    add_breadcrumb t '.edit_team'
  end

  # POST /teams
  def create
    @team = Team.create_and_subscribe_admin(team_params, current_user)
    respond_with @team, location: -> { teams_url }
  end

  # PATCH/PUT /teams/1
  def update
    @team.update(update_team_params)
    respond_with @team, location: -> { teams_url }
  end

  def invitations
    @team_invitation = TeamInvitation.new(team: @team)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def team_params
    params.require(:team).permit(:title, :public, {join_requirement_ids: []})
  end

  def update_team_params
    params.require(:team).permit(:title, :public)
  end
end
