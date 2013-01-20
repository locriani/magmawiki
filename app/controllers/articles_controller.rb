class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @current_revision = @article.build_current_revision
  end

  def create
    @article = Article.create(create_params)

    if @article.persisted?
      redirect_to articles_path, notice: "Article successfully created!"
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

private

  def create_params
    params[:article].permit(:title, current_revision_attributes: [:body, :engine, :edit_summary])
  end
end
