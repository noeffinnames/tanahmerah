class AddUserOwedToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :transacting_user_id, :integer
    add_column :expenses, :contingency_funded, :boolean, :default => false
  end
end
