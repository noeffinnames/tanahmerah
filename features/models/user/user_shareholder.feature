Feature: Log on to the system
  In order to perform shareholder functions
  As a shareholder
  I want to log in to access sensitive transactions and data
    
  Scenario: Shareholder can see the list of all users
    Given I am logged in as shareholder Fiona
    And some users exist
    When I visit the list of users
    Then I see all users

  Scenario: Logging out
    Given I am logged in as shareholder Fiona
    When I log out
    Then I am no longer logged in

  Scenario: Elevating a user to a shareholder
    Given I am logged in as shareholder Fiona
      And an ordinary user Ben exists
    When I elevate ordinary user Ben to a 20% shareholder
    Then shareholder Ben has a 20% shareholding
    
  

