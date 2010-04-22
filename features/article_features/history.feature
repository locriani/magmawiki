Feature: History
    In order to view a old versions of articles
    As a user
    I want to be able to view an article's revisions

    Scenario: View first revision
	Given I am reading and article with 20 revisions
	And the first revision has text "I am a revision"
	When I click on "history"
	Then I should see a list of 20 revisions
	When I click on the first revision
	Then I should see "I am a revision"

    Scenario: View revision 3
	Given I am reading and article with 15 revisions
	And revision 3 has text "what"
	When I click on "history"
	Then I should see a list of 15 revisions
	When I click on revision 3
	Then I should see "what"