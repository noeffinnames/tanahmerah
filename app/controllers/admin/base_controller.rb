class Admin::BaseController < ApplicationController

  @@debugger_on = false
  
  #debugger if @@debugger_on

  before_filter :restrict_to_shareholder

  protected
  def restrict_to_shareholder
    unless @current_user #defensive edit here as ApplicationController covers
      flash[:warning] = 'You must be logged in to perform that action.'
      redirect_to root_path
    end

    unless @current_user.shareholder
      flash[:warning] = 'You do not have authority to perform that action.'
      redirect_to root_path
    end

  end

  
end
