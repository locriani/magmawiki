module LoggingHelper
  $_logging_helper_logging_start_time = Hash.new
  $_logging_helper_logging_end_time = Hash.new
  
  def begin_logging(identifier)
    $_logging_helper_logging_start_time[identifier] = Time.now.utc
  end
  
  def finish_logging(identifier)
    $_logging_helper_logging_end_time[identifier] = Time.now.utc
  end
  
  def output_logging_data(identifier)
    total_logging_time = ($_logging_helper_logging_end_time[identifier] - $_logging_helper_logging_start_time[identifier])
    
    output_string = %{
<!-- #{h identifier.to_s}: -->
<!-- Prepared in #{"%4.5f" % total_logging_time}sec -->
    }
    
    output_string.html_safe!
    
    return output_string
  end
end
