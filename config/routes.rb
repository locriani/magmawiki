ActionController::Routing::Routes.draw do |map|
  # user routes
  map.resources :users
  map.resource :user_session
  
  map.with_options :controller => 'articles' do |map|
    # create
    map.new_article     'wiki/new',         :action => 'new'
    map.create_article  'wiki/create/:id',  :action => 'create'
    
    # read
    map.connect         'wiki/',            :action => 'index'
    map.show_article    'wiki/read/:id',    :action => 'show'
    
    # update
    map.edit_article    'wiki/edit/:id',    :action => 'edit'
    map.update_article  'wiki/update/:id',  :action => 'update'
    
    # destroy
    # NYI
  end
  
  map.show_history      'wiki/revision/history/:id',                          :controller => :revisions, :action => 'index'
  map.show_revision     'wiki/revision/show/:revision_id/:id/',               :controller => :revisions, :action => 'show'
  map.diff_revision     'wiki/revision/diff/:revision_1/:revision_2/:id/',    :controller => :revisions,  :action => 'diff'
  
  map.root :controller => :articles, :action => :show, :id => "Main_page"
end
