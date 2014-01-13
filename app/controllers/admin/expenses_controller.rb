class Admin::ExpensesController < Admin::BaseController

  def new
    @expense = Expense.new
    render "new"
  end
  
end
