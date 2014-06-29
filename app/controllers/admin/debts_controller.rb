class Admin::DebtsController < Admin::BaseController

  

  def index
    @debt_portfolio_positions = Debt.all
  end

  def show
    id = params[:creditor_id] # retrieve the creditor's user_ID from URI route
    @debt_portfolio_position = Debt.find(id) # value object holding the portfolio of debts for a creditor
    # will render app/views/admin/debts/show.html.haml by default
  end

  

  
  private

  def debt_params
    params.require(:debt).permit(:creditor_id, :debt_portfolio_position)
  end
  
end
