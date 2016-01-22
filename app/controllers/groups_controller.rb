class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :search_topics]

  # GET /groups
  def index
    @groups = Group.where(parent: nil)
  end

  # GET /groups/1/search_topics
  def search_topics
    @title = @group.title
    @q = search_params[:q].to_s.squish
    @results = Topic.search(@q).where(group: @group).page(params[:topic_page])

    render 'search/index'
  end

  # GET /groups/1
  def show
    unless @subscription = Subscription.find_by(user: current_user, group: @group)
      @subscription = Subscription.new(user: current_user, group: @group)
    end

    @group.parents.each do |parent|
      add_breadcrumb parent.title, group_path(parent)
    end

    @popular = @group.topics.popular.page(params[:page_popular])
    @controversial = @group.topics.controversial.page(params[:page_controversial])
    @recent = @group.topics.recent.page(params[:page_recent])
    @subgroups = @group.children.page(params[:page_subgroups])

    add_breadcrumb @group.title
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
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
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
