class SearchController < ApplicationController
  def index
    @q = search_params[:q].to_s.squish
    @topics = Topic.search(@q).page(params[:topic_page])
    @groups = Group.search(@q).page(params[:group_page])
  end

  private

  def search_params
    params.require(:search).permit(:q)
  end
end
