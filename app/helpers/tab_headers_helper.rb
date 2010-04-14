module TabHeadersHelper
  # article_tab requires two parameters, and prepares the semantic markup (html) for
  # the article tab in either the active or inactive state.
  # It checks to see if the object (article) is nil or not saved to the database; in either
  # of these cases, it will instead link to # instead of calling the link_to helper.
  #
  # TODO: Factor out the common class code (divs, active state, etc)
  # Parameters:
  # article:: The article object relevant to this tab.  If there is no article, pass in nil.
  # is_active:: Boolean indicator as to whether or not the tab will have the active styles
  def article_tab(article, is_active)
  
    if is_active
      active = "active"
    else
      active = "inactive"
    end
    
    if article.nil? || article.id.nil?
      article_string = "<a href=\"#\">Article</a>"
  	else
  		article_string = link_to("Article", article_path(article))
  	end
    
    output_string  = %{
      <div class="group #{active} left">
        <div class="text">
          #{article_string}
        </div>
      </div>
    }
    return output_string
  end
  # Like the article_tab method, the talk_tab method expects two parameters and prepares the semantic
  # markup (html) for the talk tab in either an inactive or active state.
  # This has not yet been implemented.
  def talk_tab(talk_forum, is_active)
    #TODO: Implement this
    output_string = %{
      <div class="group inactive right">
        <div class="text">
          <a href="#">Talk</a>
        </div>
      </div>
    }
    
    return output_string
  end
  
  
  def read_tab(article, is_active)
    output_string = %{
      <div class="group active left">
    	    <div class="text">
    	      <a href="#">Read</a>
    	    </div>
    	</div>
    }
  
    return output_string
  end
  
  def edit_tab(article, is_active)
    output_string = %{
      <div class="group inactive">
    	    <div class="text">
    	      <a href="#">Edit</a>
    	    </div>
    	</div>
    }
    
    return output_string
  end
  
  def history_tab(article, is_active)
    output_string = %{
      <div class="group inactive">
    	    <div class="text">
    	      <a href="#">History</a>
    	    </div>
    	</div>
    }
    
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
end