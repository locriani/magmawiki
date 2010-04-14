module LoggingHelper
  def begin_logging
    $logging_start_time = Time.now.utc
  end
  
  def finish_logging
    $logging_end_time = Time.now.utc
  end
  
  def output_logging_data
    return "Document prepared in #{$logging_end_time - $logging_start_time}s"
  end
end
