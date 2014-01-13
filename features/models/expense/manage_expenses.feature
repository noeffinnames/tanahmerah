Feature: Display the list of expenses
  In order to know which expenses have been incurred
  As a shareholder
  I want to see a list of all expenses
 
  Scenario: Display the list of all expenses in the register
    Given some expenses are in the register
    When I visit the list of expenses
    Then I see all expenses
