Feature: History
    In order to view old versions of articles
    As a user
    I want to be able to view an article's revisions

    Scenario: View revision 1
		Given I am reading an article with 20 revisions
		And revision 1 has text "I am a revision"
		When I follow "history"
		Then I should see a list of 20 revisions
		When I follow "Revision 1"
		Then I should see "You are viewing an older revision of this page"
		And I should see "I am a revision"

    Scenario: View revision 3
		Given I am reading an article with 15 revisions
		And revision 3 has text "what"
		When I follow "history"
		Then I should see a list of 15 revisions
		When I follow "Revision 3"
		Then I should see "You are viewing an older revision of this page"
		And I should see "what"
