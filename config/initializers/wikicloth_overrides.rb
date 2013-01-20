class WikiParser < WikiCloth::Parser

  url_for do |url|
    url.gsub(/\s/,"_")
  end

  link_attributes_for do |page|
    article = Article.find_by_title(page)
    article.nil? ? {:href => "/articles/new", :class => "redlink"} : {:href => "/articles/#{article.to_param}"}
  end

end