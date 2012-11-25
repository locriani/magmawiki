Magmawiki::Application.routes.draw do
  get "wiki/*article" => "articles#show", as: "article"
  get "edit/*article" => "articles#edit", as: "edit_article"
end
