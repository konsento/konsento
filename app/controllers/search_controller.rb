class SearchController < ApplicationController
  def index
    @q = search_params[:q].to_s.squish
    @results = {
      topics: Topic.for_user(current_user).search(@q).page(params[:topic_page]),
      groups: Group.search(@q).page(params[:group_page])
    }

    add_breadcrumb t '.title'
  end

  private

  def search_params
    params.require(:search).permit(:q)
  end
end
