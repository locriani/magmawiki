class ArticlesController < ApplicationController

  def index
    @articles = Article.all
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @article = Article.find_by_slug(params[:id].downcase, :include => :current_revision)
    @toolbar_locals = { :article            => @article,
                        :article_active     => true,
                        :read_active        => true}
                        
    if @article.nil?
      redirect_to edit_article_url(params[:id])
    else
      @title = @article.title
      respond_to do |format|
        format.html
      end
    end
  end
  
  def new
    @article = Article.new
    @article.current_revision = @article.revisions.build
    
    @toolbar_locals = { :article            => @article,
                        :article_active     => true,
                        :edit_active        => true}
    
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @article = Article.new(params[:article])
    revision = @article.revisions.build(params[:revision])
    revision.approved = true
    if @article.save
      flash[:notice] = I18n.t 'article.create_message'
      redirect_to show_article_url(@article)
    else
      render :action => :new
    end
  end
  
  def edit
    unless @article = Article.find_by_slug(params[:id].downcase, :include => :current_revision)
      @article = Article.new(:title=>params[:id])
      @article.current_revision = Revision.new
    end

    # We don't care about the previous revision's summary, because this will be a new revision
    @article.current_revision.summary = ""
    @toolbar_locals = { :article            => @article,
                        :article_active     => true,
                        :edit_active        => true}
  end

  def editsec
    @article = Article.find_by_slug(params[:id].downcase, :include => :current_revision)


    # We don't care about the previous revision's summary, because this will be a new revision
    @article.current_revision.body = WikiParser.new(:data => @article.current_revision.body).sections[params[:section].to_i][:content]
    @section = params[:section].to_i
    @article.current_revision.summary = ""
    @toolbar_locals = { :article            => @article,
                        :article_active     => true,
                        :edit_active        => true}
  end

  def update
    @article = Article.find_or_initialize_by_slug(params[:id].downcase, :include => :current_revision)

    revision = @article.revisions.build(params[:revision])
    revision.approved = true
    
    revision.wiki_session = WikiSession.create(:user => current_user)
    if @article.update_attributes(params[:article])
      flash[:notice] = I18n.t 'article.update_message'
      redirect_to show_article_url(@article)
    else
      render :action => :edit
    end
  end

  def updatesec
    @article = Article.find_or_initialize_by_slug(params[:id].downcase, :include => :current_revision)

    rev = params[:revision]
    rev[:body] = @article.current_revision.body.sub(WikiParser.new(:data => @article.current_revision.body).sections[params[:section].to_i][:content], rev[:body])

    revision = @article.revisions.build(rev)
    revision.approved = true
    
    revision.wiki_session = WikiSession.create(:user => current_user)
    if @article.update_attributes(params[:article])
      flash[:notice] = I18n.t 'article.update_message'
      redirect_to show_article_url(@article)
    else
      render :action => :edit
    end
  end
  
end
