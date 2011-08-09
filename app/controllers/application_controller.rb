# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :initialize_toolbar, :set_locale
  helper :all
  helper_method :title, :head, :initialize_toolbar, :current_locale
  protect_from_forgery

  # TODO: This is a hack to cleanup error fields in forms until we get a chance to actually look at the problem (and our css) in detail
  ActionView::Base.field_error_proc = Proc.new{ |html_tag, instance| "#{html_tag}" }

  
private
  def current_locale
    locale = I18n.locale if locale.nil?
    return locale
  end
  
  def set_locale
    I18n.locale = current_locale
  end
  
  def initialize_toolbar
    @toolbar_locals = {}
  end

end
