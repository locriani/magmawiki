ActionController::Routing::Routes.draw do |map|
  # user routes
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  
  map.resources :users
  map.resource :user_session

  map.with_options :controller => 'articles' do |map|
    # create
    map.new_article     '/new',         :action => 'new'
    map.create_article  '/create/:id',  :action => 'create'

    # update
    map.edit_article    '/edit/:id',    :action => 'edit'
	map.update_article  '/update/:id',  :action => 'update'

    # comments
    map.discuss         '/discuss/:id',     :controller=>'topic', :action => 'index'

    # read
    map.connect         '/wiki/',            :action => 'index'
    map.show_article    '/wiki/:id',         :action => 'show'

    # destroy
    # NYI
  end
  
  map.show_history      '/revision/history/:id',                                :controller => :revisions, :action => 'index'
  map.show_revision     '/revision/:revision_id/show/:id/',                     :controller => :revisions, :action => 'show'
  map.diff_revision     '/revision/:revision_1_id/diff/:revision_2_id/:id/',    :controller => :revisions,  :action => 'diff'
  
  map.root :controller => :articles, :action => :show, :id => "Main_page"
end
