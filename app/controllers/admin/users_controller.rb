class Admin::UsersController < Admin::BaseController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User #{@user.name} was successfully created."
      redirect_to admin_users_path and return
    end
    flash[:notice] = @user.errors.full_messages.to_sentence
    render :action => 'new'

  end

  def index
    @users = User.all
  end

  def show
    id = params[:id] # retrieve user ID from URI route
    @user = User.find(id) # look up user by unique ID
    # will render app/views/admin/users/show.html.haml by default
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    if @user.update_attributes(user_params)
      flash[:notice] = "User #{@user.name} was successfully updated."
      redirect_to admin_user_path(@user) and return
    end

    flash[:notice] = @user.errors.full_messages.to_sentence
    render :action => 'edit'
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:notice] = "User #{@user.name} deleted."
    redirect_to admin_users_path
  end

  
  private

  def user_params
    params.require(:user).permit(:name, :shareholder, :shareholding_percent)
  end
  
end
