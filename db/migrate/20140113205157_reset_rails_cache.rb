class ResetRailsCache < ActiveRecord::Migration
  def change
    #needed to flush rails column cache after rename of column 'type' to 'category'
    Expense.reset_column_information
  end
end
