class ProposalsController < ApplicationController
  # GET /proposals/1
  def show
    @proposal = Proposal.find(params[:id])
    @comment = Comment.new(commentable: @proposal, user: current_user)
    @is_user_subscribed = @proposal.topic.group.is_user_subscribed?(current_user)
    @comments = @proposal.comments.order(id: :desc).page(params[:page])

    add_breadcrumb @proposal.topic.group.title, topic_path(@proposal.topic)
    add_breadcrumb @proposal.topic.title, topic_path(@proposal.topic)
    add_breadcrumb Proposal.model_name.human
  end

  # POST /proposals
  def create
    if @proposal = Proposal.create(proposal_params)
      redirect_to @proposal.topic
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:user_id, :parent_id, :section_id, :content)
  end
end
