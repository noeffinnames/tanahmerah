class Expense < ActiveRecord::Base

  monetize :amount_cents 

  def self.all_categories
    Array ['Council etc.', 'Electricity', 'Garden', 'Equipment', 'Finance', 'Gas', 'Other']
  end

  def self.all_shareholder_names_and_ids
    User.all_shareholder_names_and_ids
  end

  def transacting_user_name
    User.find(self.transacting_user_id).name
  end

  validates :incurred_date, :presence => true
  validates :amount, :numericality => {greater_than_or_equal_to: 0.01}, :presence => true
  validates :category, :presence => true
  validates :category, :inclusion => {:in => Expense.all_categories}
  validates :transacting_user_id, :presence => true
  validates :transacting_user_id, :inclusion => {:in => User.all_shareholder_ids}
  validates :contingency_funded, inclusion: [true, false]
  validate :shareholding_percent_has_integrity   #, :on => :update

  #TODO - add date validation - need Rails 4 version of https://github.com/adzap/validates_timeliness/

  private

  before_destroy :delete_journals
  before_save :manage_journals

  def shareholding_percent_has_integrity
    errors.add(:shareholding_percent, 'must total 100% across all shareholders before expenses can be managed. Go to User maintenance and fix.') if (!User.shareholding_percent_has_integrity)
  end

  def manage_journals
debugger
    delete_journals
    if (!self.contingency_funded) then
      create_journals
    end
  end

  def delete_journals
debugger
    Journal.destroy_all "expense_id = #{self.id}"
  end

  def create_journals
debugger
    User.get_shareholders.each do |shareholder|
      share_amount = self.amount * (shareholder.shareholding_percent.to_f/100)
      journal = Journal.create :expense_id => self.id, :owed_user_id => self.transacting_user_id, :owing_user_id => shareholder.id, :amount => share_amount, :incurred_date => self.incurred_date
      journal.save
    end
  end

end
