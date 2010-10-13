# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :initialize_toolbar, :set_locale
  helper :all
  helper_method :current_user_session, :current_user, :title, :head, :initialize_toolbar, :current_locale
  protect_from_forgery

  # TODO: This is a hack to cleanup error fields in forms until we get a chance to actually look at the problem (and our css) in detail
  ActionView::Base.field_error_proc = Proc.new{ |html_tag, instance| "#{html_tag}" }

  
private
  def current_locale
    locale = current_user.preferences[:locale] unless current_user.nil?
    locale = I18n.locale if locale.nil?
    return locale
  end
  
  def set_locale
    I18n.locale = current_locale
  end
  
  def initialize_toolbar
    @toolbar_locals = {}
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def require_user
    if current_user.nil?
      flash[:notice] = I18n.t 'session.login.access_error'
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    unless current_user.nil?
      flash[:notice] = I18n.t 'session.logout.access_error'
      redirect_to root_url
      return false
    end
  end
end