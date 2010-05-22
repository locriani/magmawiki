ActionController::Routing::Routes.draw do |map|
  # user routes
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  
  map.resources :users
  map.resource :user_session

  map.with_options :controller => 'articles' do |map|
    # create
    map.new_article     'wiki/new',         :action => 'new'
    map.create_article  'wiki/create/:id',  :action => 'create'

    # update
    map.edit_article    'wiki/edit/:id',    :action => 'edit'
    map.update_article  'wiki/update/:id',  :action => 'update'

    # comments
    map.discuss         '/discuss/:id',     :controller=>'topic', :action => 'index'

    # read
    map.connect         'wiki/',            :action => 'index'
    map.show_article    'wiki/:id',         :action => 'show'

    # destroy
    # NYI
  end
  
  map.show_history      '/revision/history/:id',                          :controller => :revisions, :action => 'index'
  map.show_revision     '/revision/show/:revision_id/:id/',               :controller => :revisions, :action => 'show'
  map.diff_revision     '/revision/diff/:revision_1/:revision_2/:id/',    :controller => :revisions,  :action => 'diff'
  
  map.root :controller => :articles, :action => :show, :id => "Main_page"

  ## Default routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
