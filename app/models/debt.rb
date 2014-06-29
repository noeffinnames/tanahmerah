class Debt

  require 'debtportfolioposition'
  require 'debtposition'

  def self.all
    return get_all_debt_portfolio_positions
  end

  def self.find(creditor_id)
    return build_debt_portfolio_position(creditor_id)
  end

  def self.get_all_debt_portfolio_positions
    portfolio_positions = []
    User.all_shareholder_ids.each do | id |
	    aPPosition = find(id)   
      portfolio_positions << aPPosition
    end
    portfolio_positions
  end

  def self.build_debt_portfolio_position(creditor_id) 
    aUser = User.find_by_id(creditor_id)
    return DebtPortfolioPosition.new(creditor_id, aUser.name, build_debt_positions(aUser))
  end
  

  def self.build_debt_positions(creditor)
    debt_positions = []    
    User.get_shareholders.each do | debtor |
      next if creditor.id == debtor.id # debts to self are not a valid concept
	    aPosition = build_debt_position(creditor, debtor)   
      debt_positions << aPosition
    end
    debt_positions
  end

  def self.build_debt_position(creditor, debtor) 
    owes_amount = Journal.get_debt(creditor, debtor) #returns Money object
    owed_amount = Journal.get_credit(creditor, debtor) #returns Money object
    return DebtPosition.new(creditor.id, creditor.name, debtor.id, debtor.name, owes_amount, owed_amount)
  end

  
  
  

end
