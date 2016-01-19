module SearchHelper
  def search_result_title(result)
    text, url = 
      case result
      when Group
        [result.title, result]
      when Topic
        [result.title, result]
      else
        raise
      end

    link_to(truncate(text, length: 180), url, class: 'lead')
  end

  def search_result_content(result)
    text = 
      case result
      when Group
        result.description.to_s
      when Topic
        result.proposals.first.try(:content).to_s
      else
        raise
      end

    truncate(text, length: 400)
  end
end
