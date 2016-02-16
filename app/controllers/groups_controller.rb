class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy, :search_topics]

  # GET /groups
  def index
    @groups = Group.where(parent: nil).page(params[:page_subgroups])
  end

  # GET /groups/:parent/:child/:grandchild/...
  def show
    if params[:groups]
      groups_slugs = params[:groups].split('/').last(Group.max_ancestry_size)

      @group = groups_slugs.inject(nil) do |parent, slug|
        add_breadcrumb parent.title, recursive_group_path(parent) if parent
        Group.find_by!(parent: parent, slug: slug)
      end
    else
      @group = Group.friendly.find('global')
    end

    unless @subscription = Subscription.find_by(user: current_user, subscriptable: @group)
      @subscription = Subscription.new(user: current_user, subscriptable: @group)
    end

    topics = @group.topics.for_user(current_user)

    @popular = topics.popular.page(params[:page_popular])
    @controversial = topics.controversial.page(params[:page_controversial])
    @recent = topics.recent.page(params[:page_recent])
    @subgroups = @group.children.page(params[:page_subgroups])

    add_breadcrumb @group.title
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
