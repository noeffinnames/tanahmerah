
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

