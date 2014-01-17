class Admin::ExpensesController < Admin::BaseController

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      redirect_to admin_expenses_path and return
    end
  end

  def index
    @expenses = Expense.all
  end

  def show
    id = params[:id] # retrieve expense ID from URI route
    @expense = Expense.find(id) # look up expense by unique ID
    # will render app/views/admin/expenses/show.html.haml by default
  end

  
  private

  def expense_params
    params.require(:expense).permit(:incurred_date, :amount, :category, :remarks)
  end
  
end
