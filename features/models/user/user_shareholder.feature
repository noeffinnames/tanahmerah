Feature: Log on to the system
  In order to perform shareholder functions
  As a shareholder
  I want to log in to access sensitive transactions and data


  Scenario: Logging in with Facebook
    Given I am not logged in
    And I visit the log in page
    When I choose the Facebook authentication method
    Then I am on the Facebook log in page

  
    
  Scenario: Shareholder can see the list of all users
    Given I am logged in as a shareholder
    And some users exist
    When I visit the list of users
    Then I can see all users
    
  

