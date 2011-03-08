Given /^(?:|I )am reading an article with (\d+) revision(?:|s)$/ do |number_of_revisions|
  number_of_revisions = number_of_revisions.to_i
  @article = Factory.create(:article)
  
  number_of_revisions.times do |i|
    revision = @article.revisions.create(:body => "something")
    if (i + 1) == number_of_revisions
      revision.save
    end
  end
  Given "I am on article #{@article.title}"
end

Given /^revision (\d+) has text "([^\"]*)"$/ do |revision_number, text|
  revision_number = revision_number.to_i
  
  # CHEATING
  revision = Revision.find_by_id(revision_number)
  revision.body = text
  revision.save!
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
