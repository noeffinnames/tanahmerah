require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb'))
describe Admin::ExpensesController do
  describe "#new" do
    before do
      get :new
    end
    it "should be successful" do
      get :new
      response.should be_success
    end
    it "should create an expense object" do
      assigns(:expense).should_not be_nil
    end
  end
end
