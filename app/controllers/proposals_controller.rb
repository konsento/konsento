class ProposalsController < ApplicationController
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
