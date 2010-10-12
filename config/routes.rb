Magmawiki::Application.routes.draw do
  
  # Users and user_sessions for login / logout
  resources :users
  resources :user_sessions
  
  match 'login',  :to => 'user_sessions#create'
  match 'logout', :to => 'user_sessions#destroy'
  
  # Article URLs {
  ################
    match '/new',     :to => 'article#new',    :as => :new_article
    match '/create',  :to => 'article#create', :as => :create_article
  
    match '/edit/:id',    :to => 'article#edit',
                          :as => :edit_article
    match '/edit/section/:id/:section/',  #TODO: This entire action is nasty and needs refactoring
                          :to => 'article#editsec',
                          :as => :edit_article_section
  
    match '/update/:id',  :to => 'article#update',
                          :as => :update_article
    match '/update/section/:id/:section', #TODO: This entire action is nasty and needs refactoring
                          :to => 'article#updatesec',
                          :as => :update_article_section
   
    match '/wiki/',     :to => 'article#index'
    match '/wiki/:id',  :to => 'article#show'
  # }
  ################
  
  # Comments
  # resources :discussions NYI

  match '/revision/history/:id',   :to => 'revision#index',
                                  :as => :show_history
  match '/revision/:revision_id/show/:id', #TODO: This entire action is nasty and needs refactoring
                                  :to => 'revision#show',
                                  :as => :show_revision
  match '/revision/:revision_1_id/diff/:revision_2_id/:id', #TODO: This entire action is nasty and needs refactoring
                                  :to => 'revision#diff',
                                  :as => :diff_revision
  
  # And our root route
  root :to => 'article#index'
end
