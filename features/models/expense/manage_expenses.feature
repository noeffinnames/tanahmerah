Feature: User manages expenses
  Scenario: User adds a new expense
    When I record a "Part for Lawn Mower" expense
    Then I should be on the expense list page
    And I should see the new "Part for Lawn Mower" expense
