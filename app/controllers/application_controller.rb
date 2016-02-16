require "application_responder"

class ApplicationController < ActionController::Base
  include Clearance::Controller
  include NotificationsHelper

  self.responder = ApplicationResponder
  respond_to :html

  before_action :set_locale
  before_action :offer_login
  before_action :set_js_data
  before_action :add_root_breadcrumb

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def recursive_group_path(group)
    recursive_groups_path(group.parents.map(&:slug) + [group.slug])
  end

  helper_method :recursive_group_path

  private

  def add_root_breadcrumb
    add_breadcrumb t('home'), :root_path
  end

  def set_js_data
    gon.push(
      root_url: root_url,
      controller: params[:controller].classify,
      action: params[:action].classify,
      params: params
    )
  end

  def set_locale
    locale = :en
    browser_locale = get_browser_lang.to_s

    if browser_locale == 'pt'
      browser_locale = 'pt-BR'
    end

    if I18n.available_locales.map(&:to_s).include? browser_locale
      locale = browser_locale
    end

    @curlang = I18n.locale = locale.to_s
  end

  def get_browser_lang
    if request.env['HTTP_ACCEPT_LANGUAGE'].to_s.length > 0
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    else
      'en'
    end
  end

  def offer_login
    if request.path != sign_in_path &&
       request.path != sign_up_path &&
       !signed_in? &&
       !ignore_offer_login?
      redirect_to sign_in_path(offer: true, referer: request.original_url)
    end
  end

  def ignore_offer_login?
    cookies[:offer_login] = params[:offer_login] if params[:offer_login]
    cookies[:offer_login].to_s == 'false'
  end
end
