require 'spec_helper'

describe Article do
  it "requires unique slugs" do
    create(:article, title: "Test!")
    article = build(:article, title: "Test.")
    article.save.should eq(false)
  end

  it "generates slugs from titles" do
    article = build(:article, title: "test!")
    article.save
    article.slug.should eq("test")

    article = build(:article, title: "Fancy Title ! Thing!")
    article.save
    article.slug.should eq("fancy_title_thing")
  end
end
