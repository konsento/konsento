class Js::ProposalsController < ApplicationController
  before_action :set_proposal, only: [:agree, :abstain, :disagree]
  def agree
    @proposal.vote_agree(current_user)
  end

  def abstain
    @proposal.vote_abstain(current_user)
  end

  def disagree
    @proposal.vote_disagree(current_user)
  end

  private
  def set_proposal
    @proposal = Proposal.find(params[:id])
  end
end
