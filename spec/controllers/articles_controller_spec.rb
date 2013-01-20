require 'spec_helper'

describe ArticlesController do
  it "#create properly builds current_revision" do
    article = attributes_for(:article, current_revision: nil)
    post :create, article: article.merge(current_revision_attributes: attributes_for(:revision, body: "1234512345"))
    Article.last.current_revision.body.should eq("1234512345")
  end
end
