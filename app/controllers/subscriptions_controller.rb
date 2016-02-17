class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  # GET /subscriptions/1
  def show
  end

  # POST /subscriptions
  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.role = 'default'
    if @subscription.save
      case @subscription.subscriptable_type
        when 'Group'
          respond_with @subscription.subscriptable,
          location: -> { recursive_group_path(@subscription.subscriptable) }
        when 'Team'
          TeamInvitation.find_by(email: current_user.email, team: @subscription.subscriptable).update(accepted: true)
          redirect_to teams_path
      end
    else
      redirect_to controller: 'requirement_values',
        action: 'new',
        requirable_id: @subscription.subscriptable.id,
        requirable_type: @subscription.subscriptable_type,
        user_id: @subscription.user.id
    end
  end

  def update
    if @subscription.subscriptable_type == 'Team' &&
       current_user.is_team_admin?(@subscription.subscriptable)
      @subscription.update(subscription_update_params)
      redirect_to @subscription.subscriptable
    else
      raise
    end
  end

  # DELETE /subscriptions/1
  def destroy
    @subscription.destroy
    respond_with @subscription.subscriptable,
    location: -> { recursive_group_path(@subscription.subscriptable) }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subscription_params
      params.require(:subscription).permit(:user_id, :subscriptable_id, :subscriptable_type)
    end
   
    def subscription_update_params
      params.require(:subscription).permit(:role)
    end
end
