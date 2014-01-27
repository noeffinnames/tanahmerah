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

  describe "#create" do
    it "should create a new expense" do
      post :create, "expense" => {"incurred_date" => "01/01/2013", "amount" => "1214.23", "category" => "Council etc.", "remarks" => "December quarter"}
      assigns(:expense).should_not be_nil
      assigns(:expense).category.should == "Council etc."
    end
  end

  describe "#index" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end

end
