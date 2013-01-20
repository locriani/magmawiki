Magmawiki::Application.routes.draw do
  resources :articles do
    resources :revisions, as: "article_revisions"
  end

  root to: "articles#index"
end
