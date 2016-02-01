class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :search_proposals]
  before_action :require_login, only: [:new, :create]

  # GET /topics/1/search_proposals
  def search_proposals
    @title = @topic.title
    @q = search_params[:q].to_s.squish
    @results = Proposal.search(@q).where(topic: @topic).page(params[:proposal_page])

    render 'search/index'
  end

  # GET /topics/1
  def show
    add_breadcrumb @topic.group.title, group_path(@topic.group)
    add_breadcrumb @topic.title, topic_path(@topic)
    @comment = Comment.new(commentable: @topic, user: current_user)
    @is_user_subscribed = @topic.group.is_user_subscribed?(current_user)
  end

  # GET /groups/{group_id}/topics/new
  def new
    @topic = Group.find(params[:group_id]).topics.build
    @topic.proposals.build

    add_breadcrumb @topic.group.title, group_path(@topic.group)
    add_breadcrumb 'Novo tópico'
  end

  # POST /groups/{group_id}/topics
  def create
    @topic = Group.find(params[:group_id]).topics.create(topic_params) do |t|
      t.user = current_user
      t.proposals.each_with_index do |p, i|
        p.proposal_index = i
        p.user = current_user
      end
    end

    add_breadcrumb @topic.group.title, group_path(@topic.group)
    add_breadcrumb 'Novo tópico'

    respond_with @topic
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def topic_params
      params.require(:topic).permit(:title, :team_id, :tag_list, proposals_attributes: [
        :id,
        :content,
        :_destroy
      ])
    end

    def search_params
      params.require(:search).permit(:q)
    end
end
