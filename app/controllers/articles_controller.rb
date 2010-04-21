class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    respond_to do |format|
      format.html
      # format.xml
      # format.json
    end
  end
  
  def show
    @article = Article.find_by_slug(params[:id].downcaseo, :include => :current_revision)
    
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
    @article = Article.new(params[:article])
    revision = @article.revisions.build
    revision.body = params[:revision][:body]
    revision.summary = params[:revision][:summary]
    revision.is_current = true
    if @article.save
      flash[:notice] = "Article created successfully." #TODO: I18LN
      redirect_to article_path(@article)
    else
      render :action => :new
    end
  end
  
  def edit
    @article = Article.find_by_slug(params[:id].downcase, :include => :current_revision)
    @article.current_revision.summary = ""
  end
  
  def update
    # TODO: OH DEAR GOD WTF
    @article = Article.find_by_slug(params[:id].downcase, :include => :current_revision)
    
    
    @article.title = params[:article][:title]
    
    revision = @article.revisions.build
    revision.body = params[:revision][:body]
    revision.summary = params[:revision][:summary]
    revision.is_current = true

    if @article.save
      @article.current_revision.is_current = false
      @article.current_revision.save
      flash[:notice] = "Update successful"    
      redirect_to article_path(@article)
    else
      render :action => :edit
    end
  end
  
  def destroy
  end
end
