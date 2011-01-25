class WikiParser < WikiCloth::Parser
  url_for do |url|
    url.gsub(/\s/,"_")
  end
  
  def section_link(section)
	  "/edit/section/#{self.params[:pagename]}/#{section}"
  end
  
  template do |template|
    tmpname = template.gsub(/\s/,"_")
    article = Article.find_by_slug(tmpname.downcase, :include => :current_revision)
    article.nil? ? nil : article.current_revision.body.dup
  end
end