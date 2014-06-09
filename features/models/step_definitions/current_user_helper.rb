module Current_User_Helper


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

end
