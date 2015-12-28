class RequirementValuesController < ApplicationController
  before_action :set_requirement_value, only: [:show, :edit, :update, :destroy]
  before_action :is_user_valid, only: [:new, :create]

  def index
    @requirement_values = current_user.requirement_values
  end

  # GET /requirement_values/1
  def show
  end

  # GET /requirement_values/new
  def new
    group = Group.find(params[:group_id])
    current_user.empty_requirement_values = current_user.empty_requirement_values_for(group)
  end

  # GET /requirement_values/1/edit
  def edit
  end

  # POST /requirement_values
  def create
    group = Group.find(params[:group_id])
    ActiveRecord::Base.transaction do
      user_params[:requirement_values].each do |r|
        current_user.requirement_values.create(r)
      end
      current_user.subscriptions.create(group: group, role: 'default')
    end
    redirect_to group
  end

  # PATCH/PUT /requirement_values/1
  def update
    if @requirement_value.update(requirement_value_params)
      redirect_to @requirement_value, notice: 'Requirement value was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /requirement_values/1
  def destroy
    @requirement_value.destroy
    redirect_to requirement_values_url, notice: 'Requirement value was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requirement_value
      @requirement_value = RequirementValue.find(params[:id])
    end

    def is_user_valid
      if current_user.id.to_s != params[:user_id].to_s
        puts current_user.id
        puts params[:user_id]
        raise 'Invalid user'
      end
    end

    def user_params
      params.require(:user).permit(
        requirement_values: [
          :join_requirement_id,
          :user_id,
          :value
        ]
      )
    end
end
