Given /^I am not logged in$/ do
  I18n.default_locale = "en"
  I18n.locale = "en"
end

Given /^I have an account with username "([^\"]*)" and password "([^\"]*)"$/ do |username, password|
  @user = Factory.create(:user, :username => username, :password => password)
end