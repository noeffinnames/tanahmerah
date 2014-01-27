class Expense < ActiveRecord::Base

  def self.all_categories
    Array ['Council etc.', 'Electricity', 'Garden', 'Equipment', 'Finance', 'Gas', 'Other']
  end

  validates :incurred_date, :presence => true
  validates :amount, :presence => true
  validates :category, :presence => true

  validates :category, :inclusion => {:in => Expense.all_categories}

  #TODO - add date validation - need Rails 4 version of https://github.com/adzap/validates_timeliness/


end
