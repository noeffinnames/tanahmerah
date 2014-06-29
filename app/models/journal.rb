class Journal < ActiveRecord::Base

  monetize :amount_cents 

  validates :incurred_date, :presence => true
  validates :amount, :numericality => {greater_than_or_equal_to: 0.01}, :presence => true
  validates :owed_user_id, :presence => true
  validates :owing_user_id, :presence => true

  #TODO - add date validation - need Rails 4 version of https://github.com/adzap/validates_timeliness/

  

  def self.get_journals_for_display_for_expense(id)
    journals = []
    Journal.where(expense_id: id).each do |journal|      
      aJournal = JournalForDisplay.new(id, journal.owed_user_id, journal.owing_user_id, journal.amount)   
      journals << aJournal
    end
    journals
  end

  def self.get_debt(creditor, debtor)
    debt = 0
    Journal.where("owed_user_id = ? AND owing_user_id = ?", debtor.id, creditor.id).each do |journal|      
      debt = debt + journal.amount.cents
    end
    return Money.new(debt)
  end

  def self.get_credit(creditor, debtor)
    credit = 0
    Journal.where("owed_user_id = ? AND owing_user_id = ?", creditor.id, debtor.id).each do |journal|      
      credit = credit + journal.amount.cents
    end
    return Money.new(credit)
  end


end
