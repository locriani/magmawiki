class RevisionsController < ApplicationController
  def index
    @article = Article.find_by_slug(params[:id].slugify)
    @toolbar_locals = { :article	          => @article,
  						          :article_active		  => true,
  						          :history_active	    => true}
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @article = Article.find_by_slug(params[:id].slugify)
    @revision = @article.revisions.find(params[:revision_id])
    @toolbar_locals = { :article	          => @article,
  						          :article_active		  => true,
  						          :read_active        => true}
    if @revision.nil?
      redirect_to show_history_path(@article)
    else
      respond_to do |format|
        format.html
      end
    end
  end
  
  def diff
    @article = Article.find_by_slug(params[:id].slugify)
	  @revision = @article.revisions.find(params[:revision_1_id])
	  @revision2 = @article.revisions.find(params[:revision_2_id])
	    @toolbar_locals = { :article	          => @article,
  						          :article_active		  => true,
  						          :read_active        => true}
    if @revision.nil?
      redirect_to show_history_path(@article)
    else
      respond_to do |format|
        format.html
      end
    end	
  end
end
