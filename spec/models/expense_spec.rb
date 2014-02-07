require 'spec_helper'

describe Expense do

  include MoneyRails::TestHelpers

  context "monetization" do
    before(:each) do
      @expense = Expense.new(incurred_date: '13/12/2013', amount: '7.50', category: 'Council etc.', remarks: nil)
    end

    it 'expense supports monetization' do
      monetize(@expense.amount_cents).with_currency(:aud).should be_true
    end

    it "expense does not match wrong currency iso" do
      @expense.should_not monetize(:amount_cents).with_currency(:usd)
    end

    it 'should be able to express amount as a money object' do
      expect(@expense.amount).to eq(Money.new(750,:aud))
    end

    it 'should not be valid without a amount' do
      @expense.amount_cents = nil
      @expense.should_not be_valid
      @expense.errors[:amount].should include("can't be blank")
    end
    
    it 'should not be valid if the amount is a string' do
      @expense.amount = "ajgjgkgkgkg"
      @expense.should_not be_valid
      @expense.errors[:amount].should include("must be greater than or equal to 0.01")
    end
    
    it 'should not be valid if the amount is negative' do
      @expense.amount = -1
      @expense.should_not be_valid
      @expense.errors[:amount].should include("must be greater than or equal to 0.01")
    end
    
    it 'should not be valid if the amount is malformed' do
      @expense.amount = "1.2.3.4"
      @expense.should_not be_valid
      @expense.errors[:amount].should include("Must be a valid currency (eg. '100', '5.24', or '123,456.78')")
    end

  
  end


  it 'raises an error when saving with an invalid incurred_date' 

  

  it 'raises an error when saving with no incurred date' do
    expense = Expense.new(incurred_date: nil, amount: '4.50', category: 'Council etc.', remarks: 'Rates Dec quarter')
    expect{ expense.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Incurred date can't be blank")
  end

  it 'raises an error when saving with no amount' do
    expense = Expense.new(incurred_date: '13/12/2013', amount: nil, category: 'Council etc.', remarks: 'Rates Dec quarter')
    expect{ expense.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Amount must be greater than or equal to 0.01")
  end

  it 'allows saving with no remarks' do
    expense = Expense.new(incurred_date: '13/12/2013', amount: '7.50', category: 'Council etc.', remarks: nil)
    expect{ expense.save! }.to change(Expense, :count).from(0).to(1)
  end

  it 'raises an error when saving with an invalid category' do
    expense = Expense.new(incurred_date: '13/12/2013', amount: '7.50', category: '<<rubbish>>', remarks: 'Rates Dec quarter')
    expect{ expense.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Category is not included in the list")
  end

end
