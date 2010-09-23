
class WikiParser < WikiCloth::Parser
  url_for do |url|
    url.gsub(/\s/,"_")
  end
  
  def section_link(section)
	"/editsec/#{section}/#{self.params[:pagename]}"
  end

  def templater(template, args = nil)
    tmpname = template.gsub(/\s/,"_")
    article = Article.find_by_slug(tmpname.downcase, :include => :current_revision)
    article.nil? ? nil : article.current_revision.body
  end
	
  def template(template, args = nil)
    tmpname = template.gsub(/\s/,"_")
    article = Article.find_by_slug(tmpname.downcase, :include => :current_revision)
    tempart = article.nil? ? "" : article.current_revision.body.dup
    if !args.nil?
      argarr = args.split("|")
      argarr.length.times do |i|
        x = i + 1
        tempart.sub!("{{{" + x.to_s + "}}}", argarr[i])
      end
    end

    article.nil? ? nil : tempart
  end
end