class Js::JoinRequirementsController < ApplicationController
  respond_to :js

  def new
    @join_requirement = JoinRequirement.new
  end

  def create
    join_requirement = JoinRequirement.create(title: join_requirement_params[:title])

    RequirementValue.create(
      user: current_user,
      join_requirement: join_requirement,
      value: join_requirement_params[:value]
    )
  end

  def reload_requirements
    render :partial => "teams/join_requirement_list"
  end

  private
    def join_requirement_params
      params.require(:join_requirement).permit(
        :id,
        :title,
        :value
      )
    end
end
