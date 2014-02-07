class Admin::ExpensesController < Admin::BaseController

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      flash[:notice] = "Expense for #{@expense.amount} was successfully created."
      redirect_to admin_expenses_path and return
    end
    flash[:notice] = @expense.errors.full_messages.to_sentence
    render :action => 'new'

  end

  def index
    @expenses = Expense.all
  end

  def show
    id = params[:id] # retrieve expense ID from URI route
    @expense = Expense.find(id) # look up expense by unique ID
    # will render app/views/admin/expenses/show.html.haml by default
  end

  def edit
    @expense = Expense.find params[:id]
  end

  def update
    @expense = Expense.find params[:id]

    if @expense.update_attributes(expense_params)
      flash[:notice] = "Expense for #{@expense.amount} was successfully updated."
      redirect_to admin_expense_path(@expense) and return
    end

    flash[:notice] = @expense.errors.full_messages.to_sentence
    render :action => 'edit'
  end

  def destroy
    @expense = Expense.find params[:id]
    @expense.destroy
    flash[:notice] = "Expense for #{@expense.amount} deleted."
    redirect_to admin_expenses_path
  end

  
  private

  def expense_params
    params.require(:expense).permit(:incurred_date, :amount, :category, :remarks)
  end
  
end
