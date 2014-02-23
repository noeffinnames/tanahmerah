FactoryGirl.define do

  factory :expense do
    remarks { Faker::Lorem.sentence }
    amount { rand(1..100000) } #amount in cents
    category 'Electricity'
    expended_date Time.now
  end

  factory :no_remarks_expense, :parent => :expense do 
    remarks nil
  end

  def some_expense
    Expense.find(:first) || factory(:expense)
  end

  factory :second_expense, :parent => :expense do 
    remarks { Faker::Lorem.sentence }
    category 'Council etc.'
  end

end
