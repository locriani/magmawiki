# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :initialize_toolbar
  helper :all
  helper_method :current_user_session, :current_user, :titile, :head, :initialize_toolbar, :recaptcha_tags
  protect_from_forgery
  
  # Scrub sensitive parameters from the log
  filter_parameter_logging :password, :password_confirmation, :authenticity_token

private
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def head(page_head)
    content_for(:head) { page_head }
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
    unless current_user
      flash[:notice] = I18n.t 'session.login'
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      flash[:notice] = I18n.t 'session.logout'
      return false
    end
  end
  
  def recaptcha_tags(options ={})
    
  end
  
  def verify_recaptcha(options = {})
    # if magma_settings['RECAPTCHA_ENABLED'] = true
    #   return Recaptcha::Verify::verify_recaptcha(options)
    # else
      return true
    # end
  end
end