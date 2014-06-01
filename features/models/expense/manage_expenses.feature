Feature: Display the list of expenses
  In order to know which expenses have been incurred
  As a shareholder
  I want to see a list of all expenses
 
  Scenario: Shareholder maintains expenses in the register
    Given Frances Ben Gemma and Fiona are shareholders each with 15 percent shareholding
    And Chris is a shareholder with 40 percent shareholding
    And some expenses exist
    And I am logged in as Fiona
    When I visit the list of expenses
    Then I see all expenses
    And I can maintain any expense 
 
  Scenario: Non-shareholder cannot see expenses in the register
    Given Frances Ben Gemma and Fiona are shareholders each with 15 percent shareholding
    And Chris is a shareholder with 40 percent shareholding
    And some expenses exist
    And I am logged in as an ordinary user
    Then I am denied access to expenses  
 
  Scenario: Non-shareholder cannot maintain expenses in the register
    Given Frances Ben Gemma and Fiona are shareholders each with 15 percent shareholding
    And Chris is a shareholder with 40 percent shareholding
    And some expenses exist
    And I am logged in as an ordinary user
    Then I cannot maintain expenses
