class CreateExpensesTable < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.datetime :incurred_date
      t.float :amount
      t.string :type
      t.text :remarks
    end
  end
  def self.down
    drop_table :expenses
  end
end
