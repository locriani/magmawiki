Magmawiki::Application.routes.draw do

  # Users and user_sessions for login / logout
  #resources :users
  #resources :user_sessions
  
  match 'login',  :to => 'user_sessions#create'
  match 'logout', :to => 'user_sessions#destroy'
  
  # Article URLs {
  ################
    match '/new',     :to => 'articles#new',    :as => :new_article
    match '/create',  :to => 'articles#create', :as => :create_article
  
    match '/edit/*id',    :to => 'articles#edit',
                          :as => :edit_article
    match '/edit/section/:section/*id',  #TODO: This entire action is nasty and needs refactoring
                          :to => 'articles#editsec',
                          :as => :edit_article_section
  
    match '/update/*id',  :to => 'articles#update',
                          :as => :update_article
    match '/update/section/:section/*id', #TODO: This entire action is nasty and needs refactoring
                          :to => 'articles#updatesec',
                          :as => :update_article_section
   
    match '/wiki/',     :to => 'articles#index'
    match '/wiki/*id',  :to => 'articles#show', :as => :show_article
  # }
  ################
  
  # Comments
  match '/', :id => 'main_page',  :to => redirect('/wiki/%{id}'), :as => :discuss #NYI

  match '/revision/history/*id',   :to => 'revisions#index',
                                  :as => :show_history
  match '/revision/:revision_id/show/*id', #TODO: This entire action is nasty and needs refactoring
                                  :to => 'revisions#show',
                                  :as => :show_revision
  match '/revision/:revision_1_id/diff/:revision_2_id/*id', #TODO: This entire action is nasty and needs refactoring
                                  :to => 'revisions#diff',
                                  :as => :diff_revision
								  
  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => { :registrations => 'registrations' }  
  resources :authentications  
  root :to => 'projects#index'  
	
  # And our root route
  root :to => 'articles#index'
end
