class WelcomeController < ApplicationController
  # user shouldn't have to be logged in to see welcome
  skip_before_filter :set_current_user

  
end
