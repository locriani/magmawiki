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
    @article = Article.find_by_slug(params[:id], :include => :current_revision)
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @article = Article.new
    current_revision = @article.revisions.build
    respond_to do |format|
      format.html
    end
  end
  
  def create
    #TODO: VERY HACKISH, NEEDS CLEANUP OH MY GOD MY EYES
    @article = Article.new(params[:article])
    revision = @article.revisions.build
    revision.body = params[:current_revision][:body]
    revision.summary = params[:current_revision][:summary]
    revision.is_current = true
    if @article.save
      flash[:notice] = "Article created successfully."
      redirect_to article_path(@article)
    else
      render :action => :new
    end
  end
  
  def edit
    @article = Article.find_by_slug(params[:id], :include => :current_revision)
  end
  
  def update
  end
  
  def destroy
  end
end
