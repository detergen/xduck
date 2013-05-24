Feature: Products list page
    In order to get log in
    A visitor
    Should see a product page with menu and table with list of products, action buttons
 
    Scenario: Login home page
        Given I am on home page
		When I push Browse products button
        Then  page should have header "Products"
        And  page should have link "New"
