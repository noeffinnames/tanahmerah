When(/^I am not logged in$/) do
  @current_user.should be_nil
end

When(/^I visit the welcome page$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I see the welcome$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I am logged in as shareholder Fiona$/) do
  @shareholder_user = FactoryGirl.create(:user, :name => 'Fiona', :shareholder => true, :shareholding_percent => 20)  
  @current_user = @shareholder_user 

  #TODO - not setting session[:user_id] because of cucumber issues, so have used hack from http://stackoverflow.com/questions/1271788/session-variables-with-cucumber-stories

  rack_test_browser = Capybara.current_session.driver.browser

  cookie_jar = rack_test_browser.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
  cookie_jar[:stub_user_id] = @current_user.id

  visit '/admin/expenses'
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/expenses"
  page.should have_content('Welcome, Fiona!')
end


Given(/^I am logged in as an ordinary user$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I see access is denied$/) do
  pending # express the regexp above with the code you wish you had
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

When(/^I choose the Twitter authentication method$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I choose the Facebook authentication method$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I am logged in$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I log out$/) do 

  rack_test_browser = Capybara.current_session.driver.browser

  cookie_jar = rack_test_browser.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
  cookie_jar[:stub_user_id] = nil


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

Then(/^I see that access is denied$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I am an ordinary user$/) do
  pending # express the regexp above with the code you wish you had
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
    #next unless tr.has_selector?('elevate[href*="Elevate"]')
    next unless tr.has_content?('Ben')

    # Do stuff with trs that meet the href requirement
    click_link("Details of Ben")
    #href = tr.find('elevate')['href']
    #column_value_1 = tr.all('td')[1].text
  end




  
  page.should have_xpath('//*', :text => "Logged out successfully")
  
  
end

Then(/^shareholder Ben has a 20% shareholding$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the sum of all shareholder's shareholding_percent remains (\d+)%$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
















When /^I am logged in as an administrator$/ do #TODO
  visit '/sessions/login'
  fill_in 'user_login', :with => 'admin'
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  page.should have_content('Welcome')
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


def create_user(name, shareholder, shareholding_percent)
  visit '/admin/users/new'
  fill_in("name", :with => name)
  select(shareholder, :from => "#{:user}[#{'shareholder'}]") 
  fill_in("shareholding_percent", :with => shareholding_percent) 
  click_button("Save Changes")
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/users"
  page.should have_xpath('//*', :text => name)
  page.should have_xpath('//*', :text => shareholder)
  page.should have_xpath('//*', :text => shareholding_percent)
end








When /I should see the merge articles feature/ do
 target_selector = "#merge_with"
 assert page.has_selector?(target_selector) , "failed to find css selector with class "+target_selector
end

When /I should not see the merge articles feature/ do
  target_selector = "#merge_with"
  assert !page.has_selector?(target_selector) , "A non-admin user cannot merge articles - improperly found css selector with class "+target_selector+" as a non-admin user"
end

When /^I start editing an article$/ do
  create_article "Foobar", "Lorem Ipsum"
  click_link("Foobar")
  page.should have_xpath('//*', :text => "Lorem Ipsum")
end

Given /^there is an article titled "(.*?)" with body of "(.*?)"$/ do |arg1, arg2|
  create_article arg1, arg2
end

When /^I merge the article titled "(.*?)" with the article titled "(.*?)"$/ do |arg1, arg2|
  
  id_merge_into = Article.where(:title => arg1).first.id
  id_merge_with = Article.where(:title => arg2).first.id

  visit '/admin/content'
  current_path = URI.parse(current_url).path
  page.should have_xpath('//*', :text => arg1)

  click_link arg1
  current_path = URI.parse(current_url).path
  
  fill_in 'merge_with', :with => id_merge_with
  
  click_button 'Merge'
  
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/content/edit/"+id_merge_into.to_s

end

Then /^the article titled "(.*?)" must still exist$/ do |arg1|
  assert Article.where(:title => arg1).first
end

Then /^the article titled "(.*?)" must not exist$/ do |arg1|
  assert !Article.where(:title => arg1).first
end

Then /^the article titled "(.*?)" must have body of "(.*?)"$/ do |arg1, arg2|
  
  article = Article.where(:title => arg1).first
  article.should be_instance_of(Article)
  
  body = article.body
  body.should eql(arg2) #TODO consider use of YAML::dump(article) in error message
end


def create_article(title, body)
  visit '/admin/content/new'
  fill_in("article_title", :with => title) 
  fill_in("article__body_and_extended_editor", :with => body)
  click_button("Publish")
  current_path = URI.parse(current_url).path
  current_path.should == "/admin/content"
  page.should have_xpath('//*', :text => title)
end

