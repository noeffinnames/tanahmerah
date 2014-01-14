class ReplaceTypeWithCategoryInExpenses < ActiveRecord::Migration

  #'type' is a reserved word in rails ActiveRecord, so change to 'category'

  def up
    rename_column :expenses, :type, :category
  end

  def down
    rename_column :expenses, :category, :type 
  end
end
