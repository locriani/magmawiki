# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :start_timing
  before_filter :initialize_toolbar
  helper :all
  protect_from_forgery
  
  # Scrub sensitive parameters from the log
  filter_parameter_logging :password, :password_confirmation, :authenticity_token
  
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def head(page_head)
    content_for(:head) { page_head }
  end
  
  def initialize_toolbar
    @toolbar_locals = {}
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