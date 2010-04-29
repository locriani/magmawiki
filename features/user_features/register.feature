Feature: Registration
	In order to register an account
	As a new user
	I want to create and manage my account
	
	Scenario: Register a new account
		Given I am on the home page
		And I am not logged in
		When I follow "Register"
		Then I should see "Stuff about registering an account"
		When I fill in the following:
			| Username:         | ienjoycats            |
			| Email:            | manycats@facebook.zoo |
			| Password:         | lotsofcats            |
			| Confirm Password: | lotsofcats            |
		And I press "Register"
		Then I should see "Your account was created successfully."