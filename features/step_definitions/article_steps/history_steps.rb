Given /^(?:|I )am reading an article with (\d+) revision(?:|s)$/ do |number_of_revisions|
  # This is a bundle of mess because of the way our wikisessions model is (not) working.
  number_of_revisions = number_of_revisions.to_i
  @article = Factory.create(:article)
  @user = Factory.create(:user)  
  number_of_revisions.times do |i|
    revision = @article.revisions.build(:body => "text")
    revision.wiki_session = WikiSession.create(:user_id => @user)
    revision.engine_name = "wikicloth"
    revision.save!
  end
  Given "I am on article #{@article.title}"
end

Given /^(?:|I )am reading an article with (\d+) revision(?:|s) and revision (\d+) has text "([^\"]*)"$/ do |number_of_revisions,r_id,r_text|
  # This is a bundle of mess because of the way our wikisessions model is (not) working.
  number_of_revisions = number_of_revisions.to_i
  @article = Factory.create(:article)
  @user = Factory.create(:user)  
  number_of_revisions.times do |i|
    if i+1 == r_id.to_i then
      revision = @article.revisions.build(:body => r_text)
    else
      revision = @article.revisions.build(:body => i)
    end
    revision.wiki_session = WikiSession.create(:user_id => @user)
    revision.engine_name = "wikicloth"
    revision.save!
  end
  Given "I am on article #{@article.title}"
end

Given /^revision (\d+) has text "([^\"]*)"$/ do |revision_number, text|
  revision_number = revision_number.to_i
  
  # CHEATING
  revision = Revision.find_by_id(revision_number)
  revision.body = text
  revision.save!
  puts revision.body
end

Then /^(?:|I )should see a list of (\d+) revision(?:|s)$/ do |number_of_revisions|
  number_of_revisions = number_of_revisions.to_i
  number_of_revisions.times do |i|
    Then "I should see \"Revision #{i + 1}\""
  end
end

Given /^revision (\d+) has edit summary "([^\"]*)"$/ do |revision_number, text|
  revision_number = revision_number.to_i
  
  revision = Revision.find_by_id(revision_number)
  revision.summary = text
  revision.save!
end
