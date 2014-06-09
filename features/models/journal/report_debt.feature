Feature: Display the list of expenses
  In order to know who owes what
  As a shareholder
  I want to see a debt summary
 
  Scenario: Shareholder sees debt summary
    Given Frances Ben Gemma and Fiona are shareholders each with 15 percent shareholding
    And Chris is a shareholder with 40 percent shareholding
    And some expenses exist
    And I am logged in as Fiona
    When I visit the debt summary page
    Then I see a debt summary showing what shareholders owe each other
    And I can drill down to the journals on any debt 
 
  Scenario: Shareholder sees debt summary
    Given Frances Ben Gemma and Fiona are shareholders each with 15 percent shareholding
    And Chris is a shareholder with 40 percent shareholding
    And "Chris" incurs a $"100" expense
    And "Frances" incurs a $"90" expense
    And "Ben" incurs a $"80" expense
    And "Gemma" incurs a $"70" expense
    And "Fiona" incurs a $"60" expense
    And I am logged in as Fiona
    When I visit the debt summary page
    Then I see a debt summary showing what shareholders owe each other
    And "Ben" owes "Fiona" $"3.00"
    And "Ben" owes "Gemma" $"1.50"
    And "Chris" owes "Ben" $"-17.00"
    And "Chris" owes "Fiona" $"-9.00"
    And "Chris" owes "Frances" $"-21.00"
    And "Chris" owes "Gemma" $"-13.00"
    And "Frances" owes "Ben" $"1.50"
    And "Frances" owes "Fiona" $"4.50"
    And "Frances" owes "Gemma" $"3.00"
    And "Gemma" owes "Fiona" $"1.50"
 
  Scenario: Non-shareholder cannot see debt summary
    Given Frances Ben Gemma and Fiona are shareholders each with 15 percent shareholding
    And Chris is a shareholder with 40 percent shareholding
    And some expenses exist
    And I am logged in as an ordinary user
    Then I am denied access to the debt summary page  
 
  Scenario: Non-shareholder cannot maintain expenses in the register
    Given Frances Ben Gemma and Fiona are shareholders each with 15 percent shareholding
    And Chris is a shareholder with 40 percent shareholding
    And some expenses exist
    And I am logged in as an ordinary user
    Then I cannot drill down to the journals on any debt
