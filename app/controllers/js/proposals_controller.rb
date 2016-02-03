class Js::ProposalsController < ApplicationController
  before_action :set_proposal, except: [:index]

  def index
    topic = Topic.find(params[:topic_id])
    section = topic.sections.find(params[:section_id])
    consensus = [section.consensus]

    @is_user_subscribed = topic.group.is_user_subscribed?(current_user)

    @recent = section.proposals.recent - consensus
    @popular = section.proposals.popular - consensus
    @controversial = section.proposals.controversial - consensus
  end

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
