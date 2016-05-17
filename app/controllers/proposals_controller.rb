class ProposalsController < ApplicationController
  # GET /proposals/1
  def show
    @proposal = Proposal.find(params[:id])
    @comment = Comment.new(commentable: @proposal, user: current_user)
    @is_user_subscribed = @proposal.topic.location.is_user_subscribed?(current_user)
    @comments = @proposal.comments.order(id: :desc).page(params[:page])

    add_breadcrumb @proposal.topic.location.title, topic_path(@proposal.topic)
    add_breadcrumb @proposal.topic.title, topic_path(@proposal.topic)
    add_breadcrumb Proposal.model_name.human
  end

  # POST /proposals
  def create
    # if @proposal = Proposal.create(proposal_params)
    #   redirect_to @proposal.topic
    # end

    @proposal = Proposal.create!({
      user_id: proposal_params[:user_id],
      parent_id: proposal_params[:parent_id],
      section_id: proposal_params[:section_id],
      content: proposal_params[:content]
    })

    proposal_params[:references_attributes].each do |key, reference|
      Reference.create({
        proposal_id: @proposal[:id],
        user_id: proposal_params[:user_id],
        title: reference[:title],
        content: reference[:content]
      })
    end

    redirect_to @proposal.topic
  end

  private

  def proposal_params
    params.require(:proposal).permit(:user_id, :parent_id, :section_id, :content, references_attributes: [:id, :title, :content, :_destroy])
  end
end
