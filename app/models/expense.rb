class Expense < ActiveRecord::Base

  monetize :amount_cents 

  def self.all_categories
    Array ['Council etc.', 'Electricity', 'Garden', 'Equipment', 'Finance', 'Gas', 'Other']
  end

  validates :incurred_date, :presence => true
  validates :amount, :numericality => {greater_than_or_equal_to: 0.01}, :presence => true
  validates :category, :presence => true
  validates :category, :inclusion => {:in => Expense.all_categories}

  #TODO - add date validation - need Rails 4 version of https://github.com/adzap/validates_timeliness/

  private

  before_destroy :delete_journals
  before_save :manage_journals

  private

    def manage_journals
debugger
      delete_journals
      create_journals
    end

    def delete_journals
debugger
      Journal.destroy_all "expense_id = #{self.id}"
    end

    def create_journals
debugger
      owed_user = get_owed_user
      get_shareholders.each do |shareholder|
        share_amount = self.amount * (shareholder.shareholding_percent.to_f/100)
        journal = Journal.create :expense_id => self.id, :owed_user_id => owed_user.id, :owing_user_id => shareholder.id, :amount => share_amount, :incurred_date => self.incurred_date
        journal.save
      end

    end

    def get_owed_user
      User.find_all_by_shareholder(true).first #TODO - use shareholder paying for expense Expense.incurred_by_user_id
    end

    def get_shareholders
      User.find_all_by_shareholder(true)
    end

end
