Feature: Log ordinary user on to the system
  In order to secure the system
  As the system
  I want to protect sensitive transactions and data from ordinary users

  Scenario: Ordinary user cannot see the list of users
    Given I am logged in as an ordinary user
    When I visit the list of users
    Then I see that access is denied

  Scenario: Ordinary user cannot see expenses
    Given I am logged in as an ordinary user
    When I visit the list of expenses
    Then I see that access is denied

