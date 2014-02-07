class MonetiseAmountInExpense < ActiveRecord::Migration
  def up

    add_money :expenses, :amount #schema column name is amount_cents

    execute <<-SQL
       UPDATE Expenses
          SET amount_cents = (amount*100)
    SQL

    remove_column :expenses, :amount
    
  end
 
  def down
    
    add_column :expenses, :amount, :float

    execute <<-SQL
       UPDATE Expenses
          SET amount = (amount_cents/100)
    SQL
    remove_money :expenses, :amount
  end
end
