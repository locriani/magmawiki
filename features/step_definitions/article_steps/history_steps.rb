Given /^(?:|I )am reading an article with (\d+) revision(?:|s)$/ do |number_of_revisions|
  number_of_revisions = number_of_revisions.to_i
  @article = Factory.create(:article)
  
  number_of_revisions.times do |i|
    revision = @article.revisions.create(:body => "something")
    sleep 1
    if (i + 1) == number_of_revisions
      revision.is_current = true
      revision.save
    end
  end
  Given "I am on article #{@article.title}"
end

Given /^revision (\d+) has text "([^\"]*)"$/ do |revision_number, text|
  revision_number = revision_number.to_i
  
  @article.revisions.find_all_ordered[revision_number].body = text
  @article.revisions.find_all_ordered[revision_number].save
end

Then /^(?:|I )should see a list of (\d+) revision(?:|s)$/ do |number_of_revisions|
  number_of_revisions = number_of_revisions.to_i
  number_of_revisions.times do |i|
    Then "I should see \"revision #{i + 1}\""
  end
end