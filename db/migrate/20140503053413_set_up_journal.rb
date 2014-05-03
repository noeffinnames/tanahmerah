class SetUpJournal < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.integer :expense_id, null: true
      t.integer :owed_user_id
      t.integer :owing_user_id
      t.datetime :incurred_date
      t.money :amount
      t.timestamps
    end
  end
end
