class Admin::ExpensesController < Admin::BaseController

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)

debugger

    if @expense.save
      redirect_to admin_expenses_path and return
    end
  end

  def index
    @expenses = Expense.all
  end

  
  private

  def expense_params
    params.require(:expense).permit(:incurred_date, :amount, :category, :remarks)
  end
  
end
