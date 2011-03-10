Feature: Links
  In order to browse the wiki
  As a user
  I want to be able to see and follow links to other pages

	Scenario: Links
		Given I am reading an article that contains link "[[anotherarticle]]"
		Then I should see a link to "/wiki/anotherarticle" with text "anotherarticle"
		
	Scenario: Redlink
	  Given I am reading an article that contains link "[[fakearticle]]"
	  Then I should see a link to "/wiki/fakearticle" with text "fakearticle" and class "redlink"
	  
	Scenario: Follow Link
	  Given that article "anotherarticle" exists with title "AnotherArticle"
	  Given I am reading an article that contains link "[[anotherarticle]]"
	  When I follow "anotherarticle"
	  Then I should see "AnotherArticle"