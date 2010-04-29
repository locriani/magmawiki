class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @article = Article.find_by_slug(params[:id].downcase, :include => :current_revision)
    @toolbar_locals = { :article	          => @article,
  						          :article_active		  => true,
  						          :read_active		    => true}
    if @article.nil?
      redirect_to new_article_url
    else
      respond_to do |format|
        format.html
      end
    end
  end
  
  def new
    @article = Article.new
    @article.current_revision = @article.revisions.build
    
    @toolbar_locals = { :article	          => @article,
  						          :article_active		  => true,
  						          :edit_active		    => true}
    
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @article = Article.new(params[:article])
    revision = @article.revisions.build(params[:revision])
    revision.is_current = true
    if @article.save
      flash[:notice] = I18n.t 'article.create_message'
      redirect_to show_article_url(@article)
    else
      render :action => :new
    end
  end
  
  def edit
    @article = Article.find_by_slug(params[:id].downcase, :include => :current_revision)
    # We don't care about the previous revision's summary, because this will be a new revision
    @article.current_revision.summary = ""
    @toolbar_locals = { :article	          => @article,
  						          :article_active		  => true,
  						          :edit_active		    => true}
  end
  
  def update
    @article = Article.find_by_slug(params[:id].downcase, :include => :current_revision)
    
    current_revision = @article.current_revision
    revision = @article.revisions.build(params[:revision])
    revision.is_current = true
    
    if @article.update_attributes(params[:article])
      current_revision.is_current = false
      current_revision.save
      
      flash[:notice] = I18n.t 'article.update_message'
      redirect_to show_article_url(@article)
    else
      render :action => :edit
    end
  end
  
  def destroy
  end
end
