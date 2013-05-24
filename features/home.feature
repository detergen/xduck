Feature: Home page
    In order to get log in
    A visitor
    Should see a home page with menu
 
    Scenario: Login home page
        Given home page
        Then page should have logo "XDuck"
        And  page should have Menu "Browse Products"
