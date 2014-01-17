class Expense < ActiveRecord::Base

  def self.all_categories
    Array ['Council etc.', 'Electricity', 'Garden', 'Equipment', 'Finance', 'Gas', 'Other']
  end


end
