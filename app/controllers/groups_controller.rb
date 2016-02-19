class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy, :search_topics]

  # GET /groups
  def index
    add_breadcrumb Group.model_name.human(count: 2), groups_path

    @groups = Group.all.page(params[:page_all_groups])

    @subscribed_groups = current_user.try(:groups) || Group.none
    @subscribed_groups = @subscribed_groups.page(params[:page_subscribed_groups])

    user_location = request.safe_location
    @suggested_groups = Group.suggestions_for_location(user_location).
      page(params[:page_suggested_groups]).
      where.not(id: @subscribed_groups.pluck(:id))
  end

  # GET /groups/:parent/:child/:grandchild/...
  def show
    if params[:groups]
      groups_slugs = params[:groups].split('/').last(Group.max_ancestry_size)
      groups_slugs.unshift(current_model.slug) if current_model.is_a? Group
      groups_slugs.unshift('global') unless groups_slugs.first == 'global'

      @group = groups_slugs.inject(nil) do |parent, slug|
        Group.find_by!(parent: parent, slug: slug)
      end
    elsif params[:id]
      @group = Group.friendly.find(params[:id])
    elsif current_model.is_a?(Group)
      @group = current_model
    else
      @group = Group.friendly.find('global')
    end

    add_recursive_group_breadcrumbs @group

    unless @subscription = Subscription.find_by(user: current_user, subscriptable: @group)
      @subscription = Subscription.new(user: current_user, subscriptable: @group)
    end

    topics = @group.topics.for_user(current_user)

    @popular = topics.popular.page(params[:page_popular])
    @controversial = topics.controversial.page(params[:page_controversial])
    @recent = topics.recent.page(params[:page_recent])
    @subgroups = @group.children.page(params[:page_subgroups])
  end

  # GET /groups/1/search_topics
  def search_topics
    @title = @group.title
    @q = search_params[:q].to_s.squish
    @results = Topic.for_user(current_user).search(@q).where(group: @group).page(params[:topic_page])

    render 'search/index'
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    @group = Group.new(group_params)

    if @group.save
      respond_with @group
    else
      render :new
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      respond_with @group
    else
      render :edit
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    redirect_to groups_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_params
      params[:group]
    end

    def search_params
      params.require(:search).permit(:q)
    end
end
