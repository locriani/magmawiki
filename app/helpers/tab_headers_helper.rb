module TabHeadersHelper
  # article_tab requires two parameters, and prepares the semantic markup (html) for
  # the article tab in either the active or inactive state.
  # It checks to see if the object (article) is nil or not saved to the database; in either
  # of these cases, it will instead link to # instead of calling the link_to helper.
  #
  # Parameters:
  # article:: The article object relevant to this tab.  If there is no article, pass in nil.
  # is_active:: Boolean indicator as to whether or not the tab will have active styles.
  def article_tab(article, is_active)
      
    if article.nil? || article.id.nil?
      output_string = active_div(is_active, "left") { "<a href=\"#\">Article</a>" }
  	else
  	  output_string = active_div(is_active, "left") { link_to "Article", article_path(article) }
  	end
  	  return output_string
  end
  
  # Like the article_tab method, the talk_tab method expects two parameters and prepares the semantic
  # markup (html) for the talk tab in either an inactive or active state.
  # 
  # Parameters:
  # talk_forum:: The talk_forum object relevant to this tab.  If there is no talk forum, pass in nil.
  # is_active:: Boolean indicator as to whether or not the tab will have active styles.
  def talk_tab(talk_forum, is_active)
    if talk_forum.nil? || talk_forum.id.nil?
      output_string = active_div(is_active, "right") { "<a href=\"#\">Talk</a>" }
    else
      # TODO: This will need to be replaced with link_to code once the talk_forum object has been set up
      output_string = active_div(is_active, "right") { "<a href=\"#\">Talk</a>" }
    end
    
    return output_string
  end
  
  # Here we (also!) expect two parameters to prepare the semantic
  # markup (html) for the read tab in either an inactive or active state.
  # 
  # Parameters:
  # article:: The article object relevant to this tab.  If there is no article, pass in nil.
  # is_active:: Boolean indicator as to whether or not the tab will have active styles.
  def read_tab(article, is_active)
    if article.nil? || article.id.nil?
      # We actually probably need to grey this out if there is no relevant article yet
      output_string = active_div(is_active, "left") { "<a href=\"#\">Read</a>" }
  	else
  	  output_string = active_div(is_active, "left") { link_to "Read", show_article_path(article) }
  	end
  	
  	return output_string
  end
  
  # More of the same: We require two parameters to prepare the semantic
  # markup (html) for the edit tab in either an inactive or active state.
  # 
  # Parameters:
  # article:: The article object relevant to this tab.  If there is no article, pass in nil.
  # is_active:: Boolean indicator as to whether or not the tab will have active styles.
  def edit_tab(article, is_active)
    if article.nil? || article.id.nil?
      # We are probably on the edit action if the article does not exist.  Thus, linking elsewhere
      # would not be appropriate.
      output_string = active_div(is_active) { "<a href=\"#\">Edit</a>" }
  	else
  	  output_string = active_div(is_active) { link_to "Edit", edit_article_path(article) }
  	end
  	
    return output_string
  end
  
  # More of the same: We require two parameters to prepare the semantic
  # markup (html) for the history tab in either an inactive or active state.
  # 
  # Parameters:
  # article:: The article object relevant to this tab.  If there is no article, pass in nil.
  # is_active:: Boolean indicator as to whether or not the tab will have active styles.
  def history_tab(article, is_active)
    if article.nil? || article.id.nil?
      # We don't have the backend code set up yet (revisions)
      output_string = active_div(is_active) { "<a href=\"#\">History</a>" }
  	else
  	  output_string = active_div(is_active) { "<a href=\"#\">History</a>" }
  	end
  	
    return output_string
  end
  
  def star_tab(article, is_active)
    output_string = %{
      <div class="group inactive">
    	    <div id ="star-tool"></div>
    	</div>
    }
    
    return output_string
  end
  
  def menu_tab(article, is_active)
    output_string = %{
      <div class="group active right">
    	    <div class="text triangle">
    		<a href="#">
    		   <div id="arrow-menu">
    		      <a href="#">lool</a><br>
    		      <a href="#">what</a><br>
    		      <a href="#">huh</a><br>
    		      <a href="#">yeah</a>
    		   </div>
    		    ▼
    		</a>
    	    </div>
    	</div>
    }
    
    return output_string
  end
  
private
  def active_div(is_active, position = "")
    
    if is_active
      active = "active"
    else
      active = "inactive"
    end
    
    output_string = %{
      <div class = "group #{active} #{position}">
        <div class ="text">
          #{yield}
        </div>
      </div>
    }
    
    return output_string
  end
end