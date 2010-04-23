class RevisionsController < ApplicationController
  def index
    @article = Article.find_by_slug(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @article = Article.find_by_slug(params[:id])
    @revision = @article.revisions.find(params[:revision_id])
    
    if @revision.nil?
      redirect_to show_history_path(@article)
    else
      respond_to do |format|
        format.html
      end
    end
  end
end
