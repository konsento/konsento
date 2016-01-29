class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update]

  # GET /teams
  def index
    @teams = Team.all
  end

  # GET /teams/1
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  def create
    @team = Team.create_and_subscribe_admin(team_params, current_user)
    respond_with @team
  end

  # PATCH/PUT /teams/1
  def update
    @team.update(team_params)
    redirect_to action: 'index'
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
end
