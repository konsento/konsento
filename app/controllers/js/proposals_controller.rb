class Js::ProposalsController < ApplicationController
  before_action :set_proposal, except: [:show_by_index]

  def comments
    @comment = Comment.new(commentable: @proposal, user: current_user)
    @is_user_subscribed = @proposal.topic.group.is_user_subscribed?(current_user)
  end

  def agree
    @proposal.vote_agree(current_user)
  end

  def abstain
    @proposal.vote_abstain(current_user)
  end

  def disagree
    @proposal.vote_disagree(current_user)
  end

  def show_by_index
    @topic = Topic.find(params[:topic_id])
    @proposal_index = params[:proposal_index]
  end

  def propose
    @new_proposal = @proposal.dup
    @new_proposal.user = current_user
    @new_proposal.parent = @proposal
  end

  private
  def set_proposal
    @proposal = Proposal.find(params[:id])
  end
end
