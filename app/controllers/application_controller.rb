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
    if language_change_necessary?
      I18n.locale = the_new_locale
      set_locale_cookie(I18n.locale)
    else
      use_locale_from_cookie
    end
  end

  def language_change_necessary?
    cookies.signed[:locale].nil? || params[:locale]
  end

  def the_new_locale
    new_locale = (params[:locale] || extract_locale_from_accept_language_header)
    I18n.available_locales.map(&:to_s).include?(new_locale) ? new_locale : I18n.default_locale.to_s
  end

  def set_locale_cookie(locale)
    cookies.permanent.signed[:locale] = locale.to_s
  end

  def use_locale_from_cookie
    I18n.locale = cookies.signed[:locale]
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].presence.to_s.scan(
      /^[a-z]{2}\-[A-Z]{2}|^[a-z]{2}/
    ).first
  end

  def offer_login
    if request.path != sign_in_path &&
       request.path != sign_up_path &&
       request.request_method == 'GET' &&
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
