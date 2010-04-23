class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @article = Article.find_by_slug(params[:id].downcase, :include => :current_revision)
    
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
    respond_to do |format|
      format.html
    end
  end
  
  def create
    #TODO: VERY HACKISH, NEEDS CLEANUP OH MY GOD MY EYES
    # Most of this shouldn't be in the controller anyways, as it's article / revision specific logic
    # and should be in the model
    @article = Article.new(params[:article])
    revision = @article.revisions.build(params[:revision])
    revision.is_current = true
    if @article.save
      flash[:notice] = "Article created successfully." #TODO: i18n
      redirect_to show_article_url(@article)
    else
      render :action => :new
    end
  end
  
  def edit
    @article = Article.find_by_slug(params[:id].downcase, :include => :current_revision)
    @article.current_revision.summary = "" # We don't care about the previous revision's summary, because this is a new revision
  end
  
  def update
    @article = Article.find_by_slug(params[:id].downcase, :include => :current_revision)
    
    current_revision = @article.current_revision
    revision = @article.revisions.build(params[:revision])
    revision.is_current = true
    
    if @article.update_attributes(params[:article])
      current_revision.is_current = false
      current_revision.save
      
      flash[:notice] = "Update successful"
      redirect_to show_article_url(@article)
    else
      render :action => :edit
    end
  end
  
  def destroy
  end
end
