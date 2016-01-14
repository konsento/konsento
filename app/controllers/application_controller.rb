class ApplicationController < ActionController::Base
  before_filter :add_root_breadcrumb
  before_action :set_js_data

  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def add_root_breadcrumb
      add_breadcrumb "Início", :root_path
  end

  def set_js_data
    gon.push(
      root_url: root_url,
      controller: params[:controller].classify,
      action: params[:action].classify,
      params: params
    )
  end
end
