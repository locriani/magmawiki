Feature: History
    In order to view old versions of articles
    As a user
    I want to be able to view an article's revisions

    Scenario Outline: View revision <revision>
		Given I am reading an article with <total_revisions> revisions
		And revision <revision> has text "<revision_text>"
		When I follow "history"
		Then I should see a list of <total_revisions> revisions
		When I follow "Revision <revision>"
		Then I should see "You are viewing an older revision of this page"
		And I should see "<revision_text>"
		
		Examples:
		    | revision | total_revisions | revision_text                |
		    | 1        | 17              | I am a walrus                |
		    | 8        | 10              | This is a revision           |
		    | 3        | 10              | apples                       |
		    | 74       | 111             | this is a long revision body |
		    | 2        | 14              | I enjoy oranges              |
		
		
	Scenario: Revision summaries
		Given I am reading an article with 7 revisions
		And revision 4 has edit summary "I was modifying this article"
		When I follow "history"
		Then I should see "I was modifying this article"
		
	Scenario: Minor revisions