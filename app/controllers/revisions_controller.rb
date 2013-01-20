class RevisionsController < ApplicationController
  before_filter :load_article

  def new
    @revision = @article.revisions.new
    @revision.body = @article.current_revision.body
  end

  def create
    @revision = @article.revisions.create(revision_params)

    if @revision.persisted?
      redirect_to article_path(@article), notice: "Article edited!"
    else
      render "new"
    end
  end

private
  def load_article
    @article = Article.find(params[:article_id])
  end

  def revision_params
    params[:article_revision].permit(:body, :edit_summary)
  end
end