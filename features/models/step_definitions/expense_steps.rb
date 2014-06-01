Given(/^Frances Ben Gemma and Fiona are shareholders each with (\d+) percent shareholding$/) do |arg1|
  FactoryGirl.create(:shareholder, :name => 'Frances', :shareholding_percent => arg1)
  FactoryGirl.create(:shareholder, :name => 'Ben', :shareholding_percent => arg1)
  FactoryGirl.create(:shareholder, :name => 'Gemma', :shareholding_percent => arg1)
  FactoryGirl.create(:shareholder, :name => 'Fiona', :shareholding_percent => arg1)
end

Given(/^Chris is a shareholder with (\d+) percent shareholding$/) do |arg1|
  FactoryGirl.create(:shareholder, :name => 'Chris', :shareholding_percent => arg1)
end

Given(/^I am logged in as Fiona$/) do
  make_Fiona_the_current_user
end


def make_Fiona_the_current_user 
  @shareholder_user = User.where(:name => 'Fiona').first
  set_current_user_in_test(@shareholder_user)
end

Given(/^some expenses exist$/) do
  make_Fiona_the_current_user
  FactoryGirl.create(:expense, :transacting_user_id => @current_user.id)
  FactoryGirl.create(:expense, :transacting_user_id => @current_user.id)
  FactoryGirl.create(:expense, :transacting_user_id => @current_user.id)
  FactoryGirl.create(:expense, :transacting_user_id => @current_user.id)
end




#====================================================
#TODO - handle transacting_user_id and exercise GUI
Given(/^some expenses are in the register$/) do
  create_expense('7 May, 2010', '4500', 'Equipment', 'New lawnmower')
  create_expense('05/01/2013', '4.75', 'Garden', 'Lavander bush')
  create_expense('14/07/2013', '100.25', 'Electricity', 'June quarter bill')

  current_path = URI.parse(current_url).path
  current_path.should == "/admin/expenses"
  page.all('table#expenses tr').count.should == 4 #includes heading row
end


def create_expense(date, amount, category, remarks)
  visit '/admin/expenses/new'
  select_a_date(date, :expense, "incurred_date")
  fill_in("expense_amount", :with => amount)
  select(category, :from => "#{:expense}[#{'category'}]") 
  fill_in("expense_remarks", :with => remarks) 
  click_button("Save Changes")
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/expenses"
  page.should have_xpath('//*', :text => Date.parse(date).strftime("%d %B, %Y"))
  page.should have_xpath('//*', :text => amount)
  page.should have_xpath('//*', :text => category)
  page.should have_xpath('//*', :text => remarks)
end

#====================================================

Then(/^I can maintain any expense$/) do
  expense_id = Expense.first.id
  visit '/'  
  visit "/admin/expenses/#{expense_id}"
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/expenses/#{expense_id}"
  page.should have_content('Transacted by: Fiona')
end

Then(/^I cannot maintain expenses$/) do
  expense_id = Expense.first.id
  visit '/'  
  visit "/admin/expenses/#{expense_id}"
  current_path = URI.parse(current_url).path
  current_path.should == "/"
  page.should have_content('You do not have authority to perform that action.')
end

When(/^I visit the list of expenses$/) do
  visit '/'  
  visit '/admin/expenses'
end

Then(/^I see all expenses$/) do
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/expenses"
  page.all('table#expenses tr').count.should == 5 #includes heading row
end

Then(/^I am denied access to expenses$/) do
  visit '/'  
  visit '/admin/expenses'
  current_path = URI.parse(current_url).path
  current_path.should == "/"
  page.should have_content('You do not have authority to perform that action.')
end

Then(/^the sum of all shareholder's shareholding_percent is (\d+)%$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

#TODO - factor this code out of here and user_steps.rb to a helper?
def set_current_user_in_test(user)
  @current_user = user 
  set_stub_user_id(@current_user.id)
end

def set_stub_user_id(id)
  #TODO - not setting session[:user_id] because of cucumber issues, so have used hack from http://stackoverflow.com/questions/1271788/session-variables-with-cucumber-stories
  
  rack_test_browser = Capybara.current_session.driver.browser

  cookie_jar = rack_test_browser.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
  cookie_jar[:stub_user_id] = id
end
