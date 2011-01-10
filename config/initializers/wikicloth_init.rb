class WikiParser < WikiCloth::Parser
  url_for do |url|
    url.gsub(/\s/,"_")
  end
  
  def section_link(section)
	"/edit/section/#{section}/#{self.params[:pagename]}"
  end

  def template(template, args = nil)
    tmpname = template.gsub(/\s/,"_")
    article = Article.find_by_slug(tmpname.downcase, :include => :current_revision)
    article.nil? ? nil : article
  end
end