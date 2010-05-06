class TopicController < ApplicationController

  def index
    @article = Article.find_by_slug(params[:id])
    @topics = @article.topics
  end

  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.create(params[:topic])
    #redirect_to 
  end

end
