require 'spec_helper'

describe Expense do

  it 'raises an error when saving with no incurred date' do
    expense = Expense.new(incurred_date: nil, amount: '4.50', category: 'Council etc.', remarks: 'Rates Dec quarter')
    expect{ expense.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Incurred date can't be blank")
  end

  it 'raises an error when saving with no amount' do
    expense = Expense.new(incurred_date: '13/12/2013', amount: nil, category: 'Council etc.', remarks: 'Rates Dec quarter')
    expect{ expense.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Amount can't be blank")
  end

  it 'allows saving with no remarks' do
    expense = Expense.new(incurred_date: '13/12/2013', amount: '7.50', category: 'Council etc.', remarks: nil)
    expect{ expense.save! }.to change(Expense, :count).from(0).to(1)
  end

  it 'raises an error when saving with an invalid category' do
    expense = Expense.new(incurred_date: '13/12/2013', amount: '7.50', category: '<<rubbish>>', remarks: 'Rates Dec quarter')
    expect{ expense.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Category is not included in the list")
  end

  it 'raises an error when saving with an invalid incurred_date' 
    
end
