class DebtPosition  
# a ValueOject to support the (virtual) Debt model

  # remove the public setter interface
  attr_reader :creditor_id, :creditor_name, :debtor_id, :debtor_name, :owes_amount, :owed_amount, :net_amount
 
  def initialize(creditor_id, creditor_name, debtor_id, debtor_name, owes_amount, owed_amount)
    @creditor_id = creditor_id
    @creditor_name = creditor_name
    @debtor_id = debtor_id 
    @debtor_name = debtor_name
    @owes_amount = owes_amount #expect type Money
    @owed_amount = owed_amount #expect type Money
    @net_amount = owed_amount - owes_amount #yields type Money (we hope)
  end
 
  # VO is immutable. Here is a setter method to return a new value object

  def ==(other_debt_portfolio_position)
    self.class == other_debt_portfolio_position.class &&
    debtor_id == other_debt_portfolio_position.debtor_id &&
    creditor_id == other_debt_portfolio_position.creditor_id  &&
    creditor_name == other_debt_portfolio_position.creditor_name &&
    creditor_name == other_debt_portfolio_position.creditor_name.debtor_id &&
    creditor_name == other_debt_portfolio_position.creditor_name.debtor_name &&
    creditor_name == other_debt_portfolio_position.creditor_name.owes_amount &&
    creditor_name == other_debt_portfolio_position.creditor_name.owed_amount &&
    creditor_name == other_debt_portfolio_position.creditor_name.net_amount
  end
  alias :eql? :==
 
  #hash method required to honour equals contract
  def hash
      [@creditor_id, @creditor_name, @debtor_id, @debtor_name, @owes_amount, @owed_amount, @net_amount].hash
  end 

end
