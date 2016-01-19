class ProposalsController < ApplicationController

  # POST /proposals
  def create
    @proposal = Proposal.new(proposal_params)

    if @proposal.save
        redirect_to @proposal.topic
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def proposal_params
      params.require(:proposal).permit(:user_id, :parent_id, :topic_id, :content, :proposal_index)
    end
end
