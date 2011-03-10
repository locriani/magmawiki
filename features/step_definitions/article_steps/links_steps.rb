Given /^(?:|I )am reading an article that contains link "([^""]*)"$/ do |linked_article|
  @article = Factory.create(:article)
  @user = Factory.create(:user)  
  revision = @article.revisions.build(:body => "#{linked_article}")
  revision.wiki_session = WikiSession.create(:user_id => @user)
  revision.engine_name = "wikicloth"
  revision.save!
  Given "I am on article #{@article.title}"
end

Given /^that article "([^""]*)" exists with title "([^""]*)"$/ do |article_name,article_title|
  @article = Factory.create(:article,:title => article_title)
  @user = Factory.create(:user)  
  revision = @article.revisions.build(:body => "test")
  revision.wiki_session = WikiSession.create(:user_id => @user)
  revision.engine_name = "wikicloth"
  revision.save!
end

Then /^I should see a link to "([^""]*)" with text "([^""]*)"$/ do |url, text|
  response_body.should have_selector("a[href='#{ url }']") do |element|
    element.should contain(text)
  end
end

Then /^I should see a link to "([^""]*)" with text "([^""]*)" and class "([^""]*)"$/ do |url, text, a_class|
  response_body.should have_selector('a', :href => url, :class => a_class) do |element|
    element.should contain(text)
  end
end