Given(/^I am logged in as shareholder Fiona$/) do
  @shareholder_user = FactoryGirl.create(:user, :name => 'Fiona', :shareholder => true, :shareholding_percent => 20, :create_facebook_identity => false, :create_twitter_identity => true) 
  @shareholder_user.identities.should_not be_empty 
  set_current_user_in_test(@shareholder_user) 

  visit '/admin/expenses'
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/expenses"
  page.should have_content('Welcome, Fiona!')
end


Given(/^I am logged in as an ordinary user$/) do
  @ordinary_user = FactoryGirl.create(:user, :name => 'Ordinary')  
  set_current_user_in_test(@ordinary_user) 
end

Then(/^I am denied access to expenses$/) do
  visit '/'  
  visit '/admin/expenses'
  current_path = URI.parse(current_url).path
  current_path.should == "/"
  page.should have_content('You do not have authority to perform that action.')
end

Then(/^I am denied access to users$/) do
  visit '/'  
  visit '/admin/users'
  current_path = URI.parse(current_url).path
  current_path.should == "/"
  page.should have_content('You do not have authority to perform that action.')
end


Then(/^I see the log in page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I am invited to log\-in$/) do
  pending # express the regexp above with the code you wish you had
end


Given(/^I visit the log in page$/) do
  visit '/welcome/login'
  current_path = URI.parse(current_url).path
  current_path.should == "/welcome/login"
  page.should have_content('Please login using one of these providers:')
end

When(/^I log out$/) do 

  set_stub_user_id(nil)

  click_link("Log Out")
  page.should have_xpath('//*', :text => "Logged out successfully")
  
  current_path = URI.parse(current_url).path
  current_path.should == "/"
  @current_user = nil #TODO - what is governing this var in test?
  @current_user.should be_nil
end

Then(/^I am no longer logged in$/) do
  @current_user.should be_nil
end

When(/^an ordinary user Ben exists$/)  do
  FactoryGirl.create(:user, :name => 'Ben')
end
    

When(/^I elevate ordinary user Ben to a 20% shareholder$/) do
  visit '/admin/users'
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/users"
  page.should have_content('Shareholding %')

  page.all('#users tr').each do |tr|
    next unless tr.has_content?('Ben')

    click_link("Details of Ben")

    break
  end

  page.should have_content('Details about Ben')
  click_link("Edit")
   
  page.should have_content('Edit User')

  #page.should have_xpath("//input[@value='Ben']")
  page.should have_content('Ben')

  choose('user_shareholder_true')
  fill_in 'user_shareholding_percent', :with => 20
  click_button("Save Changes")

  #TODO check the update?
 
end

Then(/^shareholder Ben has a 20% shareholding$/) do
  visit '/admin/users'
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/users"
  page.should have_content('Shareholding %')

  page.all('#users tr').each do |tr|
    next unless tr.has_content?('Ben')

    tr.all('td')[0].text.should == 'Ben'
    tr.all('td')[1].text.should == 'true'
    tr.all('td')[2].text.should == '20'

    break
  end
end


Given(/^some users exist$/) do
  FactoryGirl.create(:shareholder)
  FactoryGirl.create(:user)
  FactoryGirl.create(:shareholder)
  FactoryGirl.create(:user)
end

When(/^I visit the list of users$/) do
  visit '/admin/users'
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/users"
  page.all('table#users tr').count.should == 6 #includes heading row
end

Then(/^I see all users$/) do
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/users"
  page.all('table#users tr').count.should == 6 #includes heading row
end




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






#=================================================

When /I should see the merge articles feature/ do
 target_selector = "#merge_with"
 assert page.has_selector?(target_selector) , "failed to find css selector with class "+target_selector
end

Then /^the article titled "(.*?)" must still exist$/ do |arg1|
  assert Article.where(:title => arg1).first
end
