require 'spec_helper'

describe Expense do

  it "raises an error when saving with no incurred date" do
    expense = Expense.new(incurred_date: nil)
    expect{ expense.save! }.to raise_error(ActiveRecord::RecordInvalid, "expense is not valid")
  end


end
