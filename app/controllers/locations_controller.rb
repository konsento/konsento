class LocationsController < ApplicationController
  before_action :set_location, only: [:edit, :update, :destroy, :search_topics]

  # GET /locations
  def index
    add_breadcrumb Location.model_name.human(count: 2), locations_path

    @locations = Location.all.page(params[:page_all_locations])

    @subscribed_locations = current_user.try(:locations) || Location.none
    @subscribed_locations = @subscribed_locations.page(params[:page_subscribed_locations])

    user_location = request.safe_location
    @suggested_locations = Location.suggestions_for_location(user_location).
      page(params[:page_suggested_locations]).
      where.not(id: @subscribed_locations.pluck(:id))
  end

  def show
    if params[:locations]
      locations_slugs = params[:locations].split('/').last(Location.max_ancestry_size)
      locations_slugs.unshift(current_model.slug) if current_model.is_a? Location
      locations_slugs.unshift('global') unless locations_slugs.first == 'global'

      @location = locations_slugs.inject(nil) do |parent, slug|
        Location.find_by!(parent: parent, slug: slug)
      end
    elsif params[:id]
      @location = Location.friendly.find(params[:id])
    elsif current_model.is_a?(Location)
      @location = current_model
    else
      @location = Location.friendly.find('global')
    end

    @subscription = @location.subscriptions.find_or_initialize_by(user: current_user)

    topics = @location.topics.for_user(current_user)
    topics = topics.where(team: current_model) if current_model.is_a?(Team)

    @popular = topics.popular.page(params[:page_popular])
    @controversial = topics.controversial.page(params[:page_controversial])
    @recent = topics.recent.page(params[:page_recent])
    @sublocations = @location.children.page(params[:page_sublocations])

    add_recursive_location_breadcrumbs @location
  end

  # GET /locations/1/search_topics
  def search_topics
    @title = @location.title
    @q = search_params[:q].to_s.squish

    @results = Topic.for_user(current_user).
               search(@q).
               where(location: @location).
               page(params[:topic_page])

    render 'search/index'
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  def create
    @location = Location.create(location_params)
    respond_with @location
  end

  # PATCH/PUT /locations/1
  def update
    @location.update(location_params)
    respond_with @location
  end

  # DELETE /locations/1
  def destroy
    @location.destroy
    respond_with @location
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit()
  end

  def search_params
    params.require(:search).permit(:q)
  end
end
