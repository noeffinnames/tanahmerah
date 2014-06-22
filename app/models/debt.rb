class Debt

  def self.all
    return get_all_debt_portfolio_positions
  end

  def self.find(creditor_id)
    return build_debt_portfolio_position
  end

  def self.get_all_debt_portfolio_positions
    return Hash.new #TODO
  end

  def self.build_debt_portfolio_position (creditor_id) 
    return new DebtPortfolioPosition(creditor_id, 'some name', Hash.new) #TODO
  end

  
  
  

end
