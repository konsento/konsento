module SearchHelper
  def search_form_url
    if params[:controller] == 'locations' && (
      params[:action] == 'show' ||
      params[:action] == 'search_topics'
    )
      search_topics_location_path(id: @location.id)
    elsif params[:controller] == 'topics' && (
      params[:action] == 'show' ||
      params[:action] == 'search_proposals'
    )
      search_proposals_topic_path(id: params[:id])
    else
      search_path
    end
  end

  def search_result_title(result)
    text, url =
      case result
      when Location
        [result.title, recursive_location_path(result)]
      when Topic
        [result.title, result]
      when Proposal
        [result.content, result]
      else
        raise
      end

    link_to(truncate(text, length: 100), url, class: 'lead')
  end

  def search_result_content(result)
    text =
      case result
      when Location
        result.description.to_s
      when Topic
        result.proposals.first.try(:content).to_s
      when Proposal
        result.content
      else
        raise
      end

    truncate(text, length: 400)
  end
end
