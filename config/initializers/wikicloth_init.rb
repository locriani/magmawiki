class WikiParser < WikiCloth::Parser
  url_for do |url|
    url.gsub(/\s/,"_")
  end
  
  def section_link(section)
	  "/edit/section/#{section}/#{self.params[:pagename]}"
  end
  
  link_attributes_for do |page|
    article = Article.find_by_slug(page.slugify, :include => :latest)
    article.nil? ? {:href => "/wiki/#{page}", :class => "redlink"} : {:href => "/wiki/#{page}"}
  end
      
  template do |template|
    article = Article.find_by_slug("template:_".concat(template).slugify, :include => :latest)
    article.nil? ? nil : article.latest.body.dup
  end
end
