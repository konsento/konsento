class MainController < ApplicationController
  def index
    @groups = Group.where(parent: nil).page(params[:page_subgroups])
    @teams = Team.all
  end
end
