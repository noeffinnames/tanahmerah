class DebtPortfolioPositon
  
# a ValueOject to support the (virtual) Debt model

  # remove the public setter interface
  attr_reader :creditor_id, :creditor_name, :debt_positions
 
  def initialize(creditor_id, creditor_name, debt_positions)
    @creditor_id = creditor_id
    @creditor_name = creditor_name
    @debt_positions = debt_positions # a collection of DebtPosition objects
  end
 
  # VO is immutable. Here is a setter method to return a new value object

  def ==(other_debt_portfolio_position)
    self.class == other_debt_portfolio_position.class &&
    debt_positions == other_debt_portfolio_position.debt_positions &&
    creditor_id == other_debt_portfolio_position.creditor_id  &&
    creditor_name == other_debt_portfolio_position.creditor_name
  end
  alias :eql? :==
 
  #hash method required to honour equals contract
  def hash
      [@creditor_id, @creditor_name, @debt_positions].hash
  end 

end
