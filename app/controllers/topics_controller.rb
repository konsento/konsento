class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :search_proposals]
  before_action :require_login, only: [:new, :create]

  # GET /topics/1/search_proposals
  def search_proposals
    @title = @topic.title
    @q = search_params[:q].to_s.squish
    @results = @topic.proposals.search(@q).page(params[:proposal_page])

    render 'search/index'
  end

  # GET /topics/1
  def show
    add_breadcrumb @topic.location.title, recursive_location_path(@topic.location)
    add_breadcrumb @topic.title, topic_path(@topic)
    @comment = Comment.new(commentable: @topic, user: current_user)
    @comments = @topic.comments.page(params[:comments_page])
    @sections = @topic.sections.page(params[:sections_page])
    @consensus = @topic.sections.page(params[:consensus_page])
    @is_user_subscribed = @topic.location.is_user_subscribed?(current_user)
  end

  # GET /locations/{location_id}/topics/new
  def new
    @topic = Location.find(params[:location_id]).topics.build
    @topic.proposals.build

    add_breadcrumb @topic.location.title, location_path(@topic.location)
    add_breadcrumb 'Novo tópico'
  end

  # POST /locations/{location_id}/topics
  def create
    location = Location.find(params[:location_id])

    @topic = location.topics.build(
      topic_params.except(:proposals_attributes, :auto_split_text)
    ) { |t| t.user = current_user }

    if process_topic_in_background?
      if @topic.valid?
        CreateTopicJob.perform_later(topic_params.merge(
          location_id: params[:location_id],
          user_id: current_user.id
        ))

        return redirect_to recursive_location_path(location), flash: {alert: t('.processing_in_the_background')}
      end
    else
      topic_params[:proposals_attributes].each_with_index do |(k, p), i|
        s = @topic.sections.build(index: i)
        s.proposals.build(user: current_user, content: p[:content])
      end

      @topic.save
    end

    add_breadcrumb @topic.location.title, location_path(@topic.location)
    add_breadcrumb 'Novo tópico'

    respond_with @topic
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(
      :title,
      :team_id,
      :auto_split_text,
      :tag_list,
      proposals_attributes: [
        :id,
        :content,
        :_destroy
      ]
    )
  end

  def search_params
    params.require(:search).permit(:q)
  end

  def process_topic_in_background?
    topic_params[:auto_split_text] == 'on' &&
    topic_params[:proposals_attributes].any? { |(k, p)| p[:content].each_line.count > 100 }
  end
end
