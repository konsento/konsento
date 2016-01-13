module ProposalsHelper
  def classes_for_vote_button(proposal, opinion)
    classes = 'btn btn-default'
    case opinion
      when 1
        classes << ' agree-button'
      when 0
        classes << ' abstain-button'
      when -1
        classes << ' disagree-button'
    end
    classes << ' current' if proposal.vote_for_user(current_user).opinion == opinion
    classes
  end
end
