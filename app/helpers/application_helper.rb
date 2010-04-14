# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # article_tab requires two parameters, and prepares the semantic markup (html) for
  # the article tab in either the active or inactive state.
  # It checks to see if the object (article) is nil or not saved to the database; in either
  # of these cases, it will instead link to # instead of calling the link_to helper.
  def article_tab(article, is_active)
    
    active = "active"
    active = "inactive" unless is_active
    
    output_string = "<div class=\"group #{active} left\">"
    output_string += "\n<div class\"=text\">"
    
    
    if article.nil? || article.id.nil?
		  output_string += "\n<a href=\"#\">Article</a>"
		else
			output_string += "\n#{link_to "Article", article_path(article)}"
		end
		
		output_string += "</div>\n</div>\n"
		
		return output_string
  end
  def talk_tab(talk_forum, is_active)
    return "<div class=\"group below right\"><div class=\"text\"><a href=\"#\">Talk</a></div></div>"
  end
end
