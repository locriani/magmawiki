Feature: Login
	In order to attribute my actions
	As a user
	I want to log in
	
	Scenario: Log in
		Given I am on the home page
		And I am not logged in
		And I have an account with username "john" and password "somepassword"
		When I follow "Login"
		Then I should see "Login"
		When I fill in the following:
			| Username: | john         |
			| Password: | somepassword |
		And I press "Submit"
		Then I should see "Successfully logged in"