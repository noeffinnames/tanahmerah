class SetTransactingUserOnExpense < ActiveRecord::Migration
  def change
    execute <<-SQL
       UPDATE Expenses
          SET transacting_user_id = (SELECT id FROM users where shareholder = true LIMIT 1)
    SQL
    execute <<-SQL
       UPDATE Expenses
          SET contingency_funded = false
    SQL
  end
end
