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
    @article = Article.find_by_id(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @article = Article.new
    revision = @article.revisions.build
    @article.current_revision = revision
    respond_to do |format|
      format.html
    end
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
