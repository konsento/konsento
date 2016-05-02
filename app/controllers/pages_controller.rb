class PagesController < ApplicationController
  layout 'pages'
  layout 'application', only: [:unavailable_content, :help]

  def unavailable_content
  end

  def help
    add_breadcrumb I18n.t('pages.help.title'), help_path
    @topics = [
      "access",
      "locations", 
      "sections",
      "tabs",
      "teams",
      "topics",
    ]

    if @topics.include?(params[:topic])
      @topic = params[:topic]
      add_breadcrumb I18n.t('pages.help.'+@topic+'.title'), help_topic_path(@topic)
    end
  end
end
