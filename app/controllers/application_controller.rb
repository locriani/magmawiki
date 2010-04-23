# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :start_timing
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation, :authenticity_token
  
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def head(page_head)
    content_for(:head) { page_head }
  end
  
  def start_timing
    @request_timer = RequestTimer.new
  end
end

class RequestTimer
  def initialize
    @start_time = Time.now.utc
  end
  def finish
    @stopped = true
    @total_time = (Time.now.utc - @start_time) * 1000
  end
  
  def total_time
    finish unless @stopped == true
    @total_time
  end
end