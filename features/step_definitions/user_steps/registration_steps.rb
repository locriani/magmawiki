Given /^I am not logged in$/ do
  @current_user = nil
end

Given /^I have an account with username "([^\"]*)" and password "([^\"]*)"$/ do |username, password|
  @user = Factory.create(:user, :login => username, :password => password)
end