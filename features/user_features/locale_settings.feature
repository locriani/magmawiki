Feature: Locales
	In order to change the viewed language
	As a user
	I want to manage my user settings
	
	Scenario: Change locale to DE
		Given I am on the home page
		And I am not logged in
		And I have an account with username "john" and password "somepassword"
		When I follow "Login"
		And I fill in the following:
			| Username: | john         |
			| Password: | somepassword |
		And I press "Submit"
		Then I should see "john"
		When I follow "john"
		Then I should see "User Preferences"
		And I should see "Language:"
		When I select "Deutsch (Sie)" from "Language:"
		And I press "Submit"
		Then I should see "Hauptseite"